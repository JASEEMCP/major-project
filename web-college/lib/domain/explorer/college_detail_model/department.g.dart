// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      name: json['name'] as String?,
      strength: (json['strength'] as num?)?.toInt(),
      shortName: json['short_name'] as String?,
      studentList: (json['student_list'] as List<dynamic>?)
          ?.map((e) => StudentList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'name': instance.name,
      'strength': instance.strength,
      'short_name': instance.shortName,
      'student_list': instance.studentList,
    };
