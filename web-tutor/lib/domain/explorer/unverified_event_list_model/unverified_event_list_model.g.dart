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
      eventPostDate: json['event_post_date'] as String?,
      registeredStudentCount:
          (json['registered_student_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UnverifiedEventListModelToJson(
        UnverifiedEventListModel instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'event_post_date': instance.eventPostDate,
      'registered_student_count': instance.registeredStudentCount,
    };
