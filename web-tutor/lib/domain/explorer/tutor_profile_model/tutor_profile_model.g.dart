// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorProfileModel _$TutorProfileModelFromJson(Map<String, dynamic> json) =>
    TutorProfileModel(
      staffId: json['staff_id'] as String?,
      name: json['name'] as String?,
      department: json['department'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      academicYear: json['academic_year'] as String?,
    );

Map<String, dynamic> _$TutorProfileModelToJson(TutorProfileModel instance) =>
    <String, dynamic>{
      'staff_id': instance.staffId,
      'name': instance.name,
      'department': instance.department,
      'email': instance.email,
      'gender': instance.gender,
      'academic_year': instance.academicYear,
    };
