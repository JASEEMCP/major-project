// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sessions _$SessionsFromJson(Map<String, dynamic> json) => Sessions(
      date: json['date'] as String?,
      eventStartTime: json['event_start_time'] as String?,
      eventEndTime: json['event_end_time'] as String?,
      facultyName: json['faculty_name'] as String?,
      venue: json['Venue'] as String?,
    );

Map<String, dynamic> _$SessionsToJson(Sessions instance) => <String, dynamic>{
      'date': instance.date,
      'event_start_time': instance.eventStartTime,
      'event_end_time': instance.eventEndTime,
      'faculty_name': instance.facultyName,
      'Venue': instance.venue,
    };
