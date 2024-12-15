import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'database_helper.dart';
import 'attendance_service.dart';

class SyncService {
  final DatabaseHelper _dbHelper;
  final AttendanceService _attendanceService;
  Timer? _syncTimer;
  bool _isSyncing = false;

  SyncService({
    required DatabaseHelper dbHelper,
    required AttendanceService attendanceService,
  })  : _dbHelper = dbHelper,
        _attendanceService = attendanceService;

  void startSync({Duration frequency = const Duration(minutes: 15)}) {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(frequency, (_) => syncData());
  }

  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  Future<void> syncData() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        return;
      }

      final unSyncedRecords = await _dbHelper.getUnSyncedAttendance();
      
      for (final record in unSyncedRecords) {
        try {
          await _attendanceService.markAttendance(
            Attendance(
              studentId: record['studentId'],
              teacherId: record['teacherId'],
              subject: record['subject'],
              date: DateTime.parse(record['date']),
              status: record['status'],
              semester: record['semester'],
            ),
          );
          await _dbHelper.markAsSynced(record['id']);
        } catch (e) {
          print('Error syncing record ${record['id']}: $e');
          // Continue with next record even if one fails
          continue;
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> get hasPendingSync async {
    final unSyncedRecords = await _dbHelper.getUnSyncedAttendance();
    return unSyncedRecords.isNotEmpty;
  }
}
