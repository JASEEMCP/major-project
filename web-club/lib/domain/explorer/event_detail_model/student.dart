import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  @JsonKey(name: 'student_id')
  String? studentId;
  @JsonKey(name: 'student_name')
  String? studentName;
  @JsonKey(name: 'academic_year')
  String? academicYear;
  String? department;
  @JsonKey(name: 'is_attended')
  bool? isAttended;

  Student({
    this.studentId,
    this.studentName,
    this.academicYear,
    this.department,
    this.isAttended,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return _$StudentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
