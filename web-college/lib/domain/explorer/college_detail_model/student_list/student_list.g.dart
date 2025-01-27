// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentList _$StudentListFromJson(Map<String, dynamic> json) => StudentList(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phone_no'] as String?,
      academicYear: json['academic_year'] as String?,
      creditEarned: (json['credit_earned'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentListToJson(StudentList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone_no': instance.phoneNo,
      'academic_year': instance.academicYear,
      'credit_earned': instance.creditEarned,
    };
