// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authority _$AuthorityFromJson(Map<String, dynamic> json) => Authority(
      authorityId: json['authority_id'] as String?,
      authorityName: json['authority_name'] as String?,
      authorName: json['author_name'] as String?,
    );

Map<String, dynamic> _$AuthorityToJson(Authority instance) => <String, dynamic>{
      'authority_id': instance.authorityId,
      'authority_name': instance.authorityName,
      'author_name': instance.authorName,
    };
