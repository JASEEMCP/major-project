// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListModel _$CategoryListModelFromJson(Map<String, dynamic> json) =>
    CategoryListModel(
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      level: json['level'] as String?,
      credits: (json['credits'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryListModelToJson(CategoryListModel instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'level': instance.level,
      'credits': instance.credits,
    };
