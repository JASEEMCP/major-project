// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentListModel _$StudentListModelFromJson(Map<String, dynamic> json) =>
    StudentListModel(
      studentId: json['student_id'] as String?,
      name: json['name'] as String?,
      registerNo: json['register_no'] as String?,
      department: json['department'] as String?,
    );

Map<String, dynamic> _$StudentListModelToJson(StudentListModel instance) =>
    <String, dynamic>{
      'student_id': instance.studentId,
      'name': instance.name,
      'register_no': instance.registerNo,
      'department': instance.department,
    };
