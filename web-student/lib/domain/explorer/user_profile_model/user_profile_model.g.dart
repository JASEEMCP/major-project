// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      registerNo: json['register_no'] as String?,
      department: json['department'] as String?,
      tutor: json['tutor'] as String?,
      academicYear: json['academic_year'] as String?,
      college: json['college'] as String?,
      creditEarned: (json['credit_earned'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'register_no': instance.registerNo,
      'department': instance.department,
      'tutor': instance.tutor,
      'academic_year': instance.academicYear,
      'college': instance.college,
      'credit_earned': instance.creditEarned,
    };
