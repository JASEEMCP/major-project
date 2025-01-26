import 'package:json_annotation/json_annotation.dart';

part 'student_list.g.dart';

@JsonSerializable()
class StudentList {
  String? name;
  String? email;
  @JsonKey(name: 'phone_no')
  String? phoneNo;
  @JsonKey(name: 'academic_year')
  String? academicYear;
  @JsonKey(name: 'credit_earned')
  int? creditEarned;

  StudentList({
    this.name,
    this.email,
    this.phoneNo,
    this.academicYear,
    this.creditEarned,
  });

  factory StudentList.fromJson(Map<String, dynamic> json) {
    return _$StudentListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentListToJson(this);
}
