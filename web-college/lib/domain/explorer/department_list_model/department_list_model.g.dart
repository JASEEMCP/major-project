// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentListModel _$DepartmentListModelFromJson(Map<String, dynamic> json) =>
    DepartmentListModel(
      departmentId: json['department_id'] as String?,
      name: json['name'] as String?,
      strength: (json['strength'] as num?)?.toInt(),
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$DepartmentListModelToJson(
        DepartmentListModel instance) =>
    <String, dynamic>{
      'department_id': instance.departmentId,
      'name': instance.name,
      'strength': instance.strength,
      'short_name': instance.shortName,
    };
