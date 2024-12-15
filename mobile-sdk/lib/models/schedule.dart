import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  final String id;
  final String subject;
  final String teacherId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int semester;
  final String room;

  Schedule({
    required this.id,
    required this.subject,
    required this.teacherId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.semester,
    required this.room,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  bool isCurrentClass() {
    final now = DateTime.now();
    final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final weekDay = now.weekday.toString();

    return weekDay == dayOfWeek &&
        currentTime.compareTo(startTime) >= 0 &&
        currentTime.compareTo(endTime) <= 0;
  }
}
