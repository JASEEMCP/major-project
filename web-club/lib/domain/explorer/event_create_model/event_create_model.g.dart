// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreateModel _$EventCreateModelFromJson(Map<String, dynamic> json) =>
    EventCreateModel(
      eventName: json['event_name'] as String?,
      eventPostDate: json['event_post_date'] as String?,
      eventExpiryDate: json['event_expiry_date'] as String?,
      eventSlotCount: (json['event_slot_count'] as num?)?.toInt(),
      sessionCount: (json['session_count'] as num?)?.toInt(),
      eventFee: (json['event_fee'] as num?)?.toInt(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      sessions: json['sessions'] == null
          ? null
          : Sessions.fromJson(json['sessions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventCreateModelToJson(EventCreateModel instance) =>
    <String, dynamic>{
      'event_name': instance.eventName,
      'event_post_date': instance.eventPostDate,
      'event_expiry_date': instance.eventExpiryDate,
      'event_slot_count': instance.eventSlotCount,
      'session_count': instance.sessionCount,
      'event_fee': instance.eventFee,
      'description': instance.description,
      'category': instance.category,
      'sessions': instance.sessions,
    };
