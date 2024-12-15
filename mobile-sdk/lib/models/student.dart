import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String id;
  final String name;
  final String email;
  final int semester;
  final String rollNumber;
  final List<String> subjects;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.semester,
    required this.rollNumber,
    required this.subjects,
  });

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
