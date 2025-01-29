// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryListModel _$CategoryListModelFromJson(Map<String, dynamic> json) =>
    CategoryListModel(
      categoryName: json['category_name'] as String?,
      credits: (json['credits'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryListModelToJson(CategoryListModel instance) =>
    <String, dynamic>{
      'category_name': instance.categoryName,
      'credits': instance.credits,
    };
