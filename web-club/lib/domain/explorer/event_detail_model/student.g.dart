// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      studentId: json['student_id'] as String?,
      studentName: json['student_name'] as String?,
      academicYear: json['academic_year'] as String?,
      department: json['department'] as String?,
      isAttended: json['is_attended'] as bool?,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'student_id': instance.studentId,
      'student_name': instance.studentName,
      'academic_year': instance.academicYear,
      'department': instance.department,
      'is_attended': instance.isAttended,
    };
