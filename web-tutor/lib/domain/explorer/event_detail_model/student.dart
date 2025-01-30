import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  @JsonKey(name: 'student_id')
  String? studentId;
  String? name;
  @JsonKey(name: 'register_no')
  String? registerNo;
  @JsonKey(name: 'credit_earned')
  int? creditEarned;
  @JsonKey(name: 'registration_id')
  String? registrationId;

  Student({
    this.studentId,
    this.name,
    this.registerNo,
    this.creditEarned,
    this.registrationId,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return _$StudentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
