// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_event_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentEventListModel _$RecentEventListModelFromJson(
        Map<String, dynamic> json) =>
    RecentEventListModel(
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      eventPostDate: json['event_post_date'] as String?,
      eventFee: (json['event_fee'] as num?)?.toInt(),
      eventSlotCount: (json['event_slot_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RecentEventListModelToJson(
        RecentEventListModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_post_date': instance.eventPostDate,
      'event_fee': instance.eventFee,
      'event_slot_count': instance.eventSlotCount,
    };
