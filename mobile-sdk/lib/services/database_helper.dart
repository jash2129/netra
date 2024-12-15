import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/attendance.dart';

class DatabaseHelper {
  static Database? _database;
  static const String attendanceTable = 'attendance';
  static const String pendingSyncTable = 'pending_sync';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'attendance_sdk.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $attendanceTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            studentId TEXT,
            teacherId TEXT,
            subject TEXT,
            date TEXT,
            status TEXT,
            semester INTEGER,
            synced INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE $pendingSyncTable(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            data TEXT,
            timestamp INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertAttendance(Attendance attendance) async {
    final db = await database;
    return await db.insert(
      attendanceTable,
      {
        'studentId': attendance.studentId,
        'teacherId': attendance.teacherId,
        'subject': attendance.subject,
        'date': attendance.date.toIso8601String(),
        'status': attendance.status,
        'semester': attendance.semester,
        'synced': 0,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getUnSyncedAttendance() async {
    final db = await database;
    return await db.query(
      attendanceTable,
      where: 'synced = ?',
      whereArgs: [0],
    );
  }

  Future<void> markAsSynced(int id) async {
    final db = await database;
    await db.update(
      attendanceTable,
      {'synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getAttendanceByDate(DateTime date) async {
    final db = await database;
    return await db.query(
      attendanceTable,
      where: 'date = ?',
      whereArgs: [date.toIso8601String()],
    );
  }
}
