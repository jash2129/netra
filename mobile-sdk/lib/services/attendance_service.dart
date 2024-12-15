import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/attendance.dart';

class AttendanceService {
  final String baseUrl;
  final String token;

  AttendanceService({required this.baseUrl, required this.token});

  Future<void> markAttendance(Attendance attendance) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/attendance/mark'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(attendance.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to mark attendance: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to mark attendance: $e');
    }
  }

  Future<List<Attendance>> getAttendanceByDate(DateTime date, String subject) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/attendance?date=${date.toIso8601String()}&subject=$subject',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Attendance.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch attendance: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to fetch attendance: $e');
    }
  }
}
