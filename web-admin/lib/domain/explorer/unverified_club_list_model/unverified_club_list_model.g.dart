// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unverified_club_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnverifiedClubListModel _$UnverifiedClubListModelFromJson(
        Map<String, dynamic> json) =>
    UnverifiedClubListModel(
      authorityId: json['authority_id'] as String?,
      authorityName: json['authority_name'] as String?,
      email: json['email'] as String?,
      authorName: json['author_name'] as String?,
    );

Map<String, dynamic> _$UnverifiedClubListModelToJson(
        UnverifiedClubListModel instance) =>
    <String, dynamic>{
      'authority_id': instance.authorityId,
      'authority_name': instance.authorityName,
      'email': instance.email,
      'author_name': instance.authorName,
    };
