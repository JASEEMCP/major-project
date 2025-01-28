// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      eventName: json['event_name'] as String?,
      eventDate: json['event_date'] as String?,
      eventFee: (json['event_fee'] as num?)?.toInt(),
      description: json['description'] as String?,
      organizationName: json['organization_name'],
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'event_name': instance.eventName,
      'event_date': instance.eventDate,
      'event_fee': instance.eventFee,
      'description': instance.description,
      'organization_name': instance.organizationName,
    };
