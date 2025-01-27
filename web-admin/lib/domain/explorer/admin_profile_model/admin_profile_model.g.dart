// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminProfileModel _$AdminProfileModelFromJson(Map<String, dynamic> json) =>
    AdminProfileModel(
      email: json['email'] as String?,
      department: json['department'] as String?,
      phoneNumber: json['phone_number'],
      academicStartYear: (json['academic_start_year'] as num?)?.toInt(),
      academicEndYear: (json['academic_end_year'] as num?)?.toInt(),
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$AdminProfileModelToJson(AdminProfileModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'department': instance.department,
      'phone_number': instance.phoneNumber,
      'academic_start_year': instance.academicStartYear,
      'academic_end_year': instance.academicEndYear,
      'gender': instance.gender,
    };
