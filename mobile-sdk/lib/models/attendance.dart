import 'package:json_annotation/json_annotation.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  final String studentId;
  final String teacherId;
  final String subject;
  final DateTime date;
  final String status;
  final int semester;

  Attendance({
    required this.studentId,
    required this.teacherId,
    required this.subject,
    required this.date,
    required this.status,
    required this.semester,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$AttendanceToJson(this);
}
