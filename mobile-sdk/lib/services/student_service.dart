import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import 'database_helper.dart';

class StudentService {
  final String baseUrl;
  final String token;
  final DatabaseHelper _dbHelper;

  StudentService({
    required this.baseUrl,
    required this.token,
    required DatabaseHelper dbHelper,
  }) : _dbHelper = dbHelper;

  Future<List<Student>> getStudentsBySubject(String subject) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/students?subject=$subject'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final students = data.map((json) => Student.fromJson(json)).toList();
        
        // Cache students locally
        await _cacheStudents(students);
        
        return students;
      } else {
        // Try to get cached students if API fails
        return await _getCachedStudents(subject);
      }
    } catch (e) {
      // Return cached students on error
      return await _getCachedStudents(subject);
    }
  }

  Future<void> _cacheStudents(List<Student> students) async {
    final db = await _dbHelper.database;
    final batch = db.batch();

    for (final student in students) {
      batch.insert(
        'students',
        student.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<List<Student>> _getCachedStudents(String subject) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'students',
      where: 'subjects LIKE ?',
      whereArgs: ['%$subject%'],
    );

    return List.generate(maps.length, (i) {
      return Student.fromJson(maps[i]);
    });
  }
}
