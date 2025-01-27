// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubProfileModel _$ClubProfileModelFromJson(Map<String, dynamic> json) =>
    ClubProfileModel(
      authorityName: json['authority_name'] as String?,
      clubEmail: json['club_email'] as String?,
      authorName: json['author_name'] as String?,
    );

Map<String, dynamic> _$ClubProfileModelToJson(ClubProfileModel instance) =>
    <String, dynamic>{
      'authority_name': instance.authorityName,
      'club_email': instance.clubEmail,
      'author_name': instance.authorName,
    };
