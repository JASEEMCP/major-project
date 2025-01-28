// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      authorityName: json['authority_name'] as String?,
      authorName: json['author_name'] as String?,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'authority_name': instance.authorityName,
      'author_name': instance.authorName,
      'events': instance.events,
    };
