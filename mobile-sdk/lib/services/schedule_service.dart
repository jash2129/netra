import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedule.dart';
import 'database_helper.dart';

class ScheduleService {
  final String baseUrl;
  final String token;
  final DatabaseHelper _dbHelper;

  ScheduleService({
    required this.baseUrl,
    required this.token,
    required DatabaseHelper dbHelper,
  }) : _dbHelper = dbHelper;

  Future<List<Schedule>> getTeacherSchedule() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/schedule'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final schedules = data.map((json) => Schedule.fromJson(json)).toList();
        
        // Cache schedule locally
        await _cacheSchedule(schedules);
        
        return schedules;
      } else {
        // Try to get cached schedule if API fails
        return await _getCachedSchedule();
      }
    } catch (e) {
      // Return cached schedule on error
      return await _getCachedSchedule();
    }
  }

  Future<Schedule?> getCurrentClass() async {
    final schedules = await getTeacherSchedule();
    return schedules.firstWhere(
      (schedule) => schedule.isCurrentClass(),
      orElse: () => null,
    );
  }

  Future<void> _cacheSchedule(List<Schedule> schedules) async {
    final db = await _dbHelper.database;
    final batch = db.batch();

    // Clear existing schedule
    batch.delete('schedule');

    for (final schedule in schedules) {
      batch.insert('schedule', schedule.toJson());
    }

    await batch.commit();
  }

  Future<List<Schedule>> _getCachedSchedule() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('schedule');

    return List.generate(maps.length, (i) {
      return Schedule.fromJson(maps[i]);
    });
  }
}
