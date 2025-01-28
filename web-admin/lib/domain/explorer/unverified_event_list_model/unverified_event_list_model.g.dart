// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unverified_event_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnverifiedEventListModel _$UnverifiedEventListModelFromJson(
        Map<String, dynamic> json) =>
    UnverifiedEventListModel(
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      eventFee: (json['event_fee'] as num?)?.toInt(),
      description: json['description'] as String?,
      sessionCount: (json['session_count'] as num?)?.toInt(),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      authority: json['authority'] == null
          ? null
          : Authority.fromJson(json['authority'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnverifiedEventListModelToJson(
        UnverifiedEventListModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_fee': instance.eventFee,
      'description': instance.description,
      'session_count': instance.sessionCount,
      'category': instance.category,
      'authority': instance.authority,
    };
