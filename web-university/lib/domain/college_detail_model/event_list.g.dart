// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventList _$EventListFromJson(Map<String, dynamic> json) => EventList(
      eventName: json['event_name'] as String?,
      eventFee: (json['event_fee'] as num?)?.toInt(),
      categoryName: json['category_name'] as String?,
      authority: json['authority'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$EventListToJson(EventList instance) => <String, dynamic>{
      'event_name': instance.eventName,
      'event_fee': instance.eventFee,
      'category_name': instance.categoryName,
      'authority': instance.authority,
      'date': instance.date,
    };
