import 'package:json_annotation/json_annotation.dart';

part 'tutor_profile_model.g.dart';

@JsonSerializable()
class TutorProfileModel {
  @JsonKey(name: 'staff_id')
  String? staffId;
  String? name;
  String? department;
  String? email;
  String? gender;
  @JsonKey(name: 'academic_year')
  String? academicYear;

  TutorProfileModel({
    this.staffId,
    this.name,
    this.department,
    this.email,
    this.gender,
    this.academicYear,
  });

  factory TutorProfileModel.fromJson(Map<String, dynamic> json) {
    return _$TutorProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TutorProfileModelToJson(this);

  TutorProfileModel copyWith({
    String? staffId,
    String? name,
    String? department,
    String? email,
    String? gender,
    String? academicYear,
  }) {
    return TutorProfileModel(
      staffId: staffId ?? this.staffId,
      name: name ?? this.name,
      department: department ?? this.department,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      academicYear: academicYear ?? this.academicYear,
    );
  }
}
