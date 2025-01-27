import 'package:json_annotation/json_annotation.dart';

part 'admin_profile_model.g.dart';

@JsonSerializable()
class AdminProfileModel {
  String? email;
  String? department;
  @JsonKey(name: 'phone_number')
  dynamic phoneNumber;
  @JsonKey(name: 'academic_start_year')
  int? academicStartYear;
  @JsonKey(name: 'academic_end_year')
  int? academicEndYear;
  String? gender;

  AdminProfileModel({
    this.email,
    this.department,
    this.phoneNumber,
    this.academicStartYear,
    this.academicEndYear,
    this.gender,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) {
    return _$AdminProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdminProfileModelToJson(this);

  AdminProfileModel copyWith({
    String? email,
    String? department,
    dynamic phoneNumber,
    int? academicStartYear,
    int? academicEndYear,
    String? gender,
  }) {
    return AdminProfileModel(
      email: email ?? this.email,
      department: department ?? this.department,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      academicStartYear: academicStartYear ?? this.academicStartYear,
      academicEndYear: academicEndYear ?? this.academicEndYear,
      gender: gender ?? this.gender,
    );
  }
}
