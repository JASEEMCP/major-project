// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      eventSessionId: json['event_session_id'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      venue: json['venue'] as String?,
      facultyName: json['faculty_name'] as String?,
      isCurrentSession: json['is_current_session'] as bool?,
      index: (json['index'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'event_session_id': instance.eventSessionId,
      'date': instance.date,
      'time': instance.time,
      'venue': instance.venue,
      'faculty_name': instance.facultyName,
      'is_current_session': instance.isCurrentSession,
      'index': instance.index,
    };
