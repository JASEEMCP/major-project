import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  String? name;
  String? email;
  @JsonKey(name: 'register_no')
  String? registerNo;
  String? department;
  String? tutor;
  @JsonKey(name: 'academic_year')
  String? academicYear;
  String? college;
  @JsonKey(name: 'credit_earned')
  int? creditEarned;

  UserProfileModel({
    this.name,
    this.email,
    this.registerNo,
    this.department,
    this.tutor,
    this.academicYear,
    this.college,
    this.creditEarned,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return _$UserProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
