// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDetailModel _$EventDetailModelFromJson(Map<String, dynamic> json) =>
    EventDetailModel(
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      description: json['description'] as String?,
      eventDate: json['event_date'] as String?,
      eventSlotCount: (json['event_slot_count'] as num?)?.toInt(),
      eventFee: (json['event_fee'] as num?)?.toInt(),
      authority: json['authority'] as String?,
      credit: (json['credit'] as num?)?.toInt(),
      category: json['category'] as String?,
      sessions: (json['sessions'] as List<dynamic>?)
          ?.map((e) => Session.fromJson(e as Map<String, dynamic>))
          .toList(),
      isRegistered: json['is_registered'] as bool?,
      registrationId: json['registration_id'] as String?,
    );

Map<String, dynamic> _$EventDetailModelToJson(EventDetailModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'description': instance.description,
      'event_date': instance.eventDate,
      'event_slot_count': instance.eventSlotCount,
      'event_fee': instance.eventFee,
      'authority': instance.authority,
      'credit': instance.credit,
      'category': instance.category,
      'sessions': instance.sessions,
      'is_registered': instance.isRegistered,
      'registration_id': instance.registrationId,
    };
