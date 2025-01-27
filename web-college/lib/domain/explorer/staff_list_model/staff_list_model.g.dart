// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffListModel _$StaffListModelFromJson(Map<String, dynamic> json) =>
    StaffListModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      department: json['department'] as String?,
      academicYear: json['academic_year'] as String?,
      gender: json['gender'] as String?,
      isTutor: json['is_tutor'] as bool?,
      isAdmin: json['is_admin'] as bool?,
    );

Map<String, dynamic> _$StaffListModelToJson(StaffListModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'department': instance.department,
      'academic_year': instance.academicYear,
      'gender': instance.gender,
      'is_tutor': instance.isTutor,
      'is_admin': instance.isAdmin,
    };
