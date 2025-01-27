// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailModel _$EventDetailModelFromJson(Map<String, dynamic> json) =>
    EventDetailModel(
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      eventPostDate: json['event_post_date'] as String?,
      eventExpiryDate: json['event_expiry_date'] as String?,
      eventSlotCount: (json['event_slot_count'] as num?)?.toInt(),
      sessionCount: (json['session_count'] as num?)?.toInt(),
      eventFee: (json['event_fee'] as num?)?.toInt(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      credit: (json['credit'] as num?)?.toInt(),
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventDetailModelToJson(EventDetailModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_post_date': instance.eventPostDate,
      'event_expiry_date': instance.eventExpiryDate,
      'event_slot_count': instance.eventSlotCount,
      'session_count': instance.sessionCount,
      'event_fee': instance.eventFee,
      'description': instance.description,
      'category': instance.category,
      'credit': instance.credit,
      'students': instance.students,
    };
