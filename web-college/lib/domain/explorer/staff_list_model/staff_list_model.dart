import 'package:json_annotation/json_annotation.dart';

part 'staff_list_model.g.dart';

@JsonSerializable()
class StaffListModel {
  String? name;
  String? email;
  String? department;
  @JsonKey(name: 'academic_year')
  String? academicYear;
  String? gender;
  @JsonKey(name: 'is_tutor')
  bool? isTutor;
  @JsonKey(name: 'is_admin')
  bool? isAdmin;

  StaffListModel({
    this.name,
    this.email,
    this.department,
    this.academicYear,
    this.gender,
    this.isTutor,
    this.isAdmin,
  });

  factory StaffListModel.fromJson(Map<String, dynamic> json) {
    return _$StaffListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StaffListModelToJson(this);
}
