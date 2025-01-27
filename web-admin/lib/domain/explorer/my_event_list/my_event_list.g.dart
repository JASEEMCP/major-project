// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEventList _$MyEventListFromJson(Map<String, dynamic> json) => MyEventList(
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      eventDate: json['event_date'] as String?,
      eventFee: (json['event_fee'] as num?)?.toInt(),
      credit: (json['credit'] as num?)?.toInt(),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$MyEventListToJson(MyEventList instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_date': instance.eventDate,
      'event_fee': instance.eventFee,
      'credit': instance.credit,
      'category': instance.category,
    };
