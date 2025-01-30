// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      studentId: json['student_id'] as String?,
      name: json['name'] as String?,
      registerNo: json['register_no'] as String?,
      creditEarned: (json['credit_earned'] as num?)?.toInt(),
      registrationId: json['registration_id'] as String?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'student_id': instance.studentId,
      'name': instance.name,
      'register_no': instance.registerNo,
      'credit_earned': instance.creditEarned,
      'registration_id': instance.registrationId,
    };
