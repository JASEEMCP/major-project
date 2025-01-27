import 'package:json_annotation/json_annotation.dart';

import 'student.dart';

part 'event_detail_model.g.dart';

@JsonSerializable()
class EventDetailModel {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_post_date')
  String? eventPostDate;
  @JsonKey(name: 'event_expiry_date')
  String? eventExpiryDate;
  @JsonKey(name: 'event_slot_count')
  int? eventSlotCount;
  @JsonKey(name: 'session_count')
  int? sessionCount;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  String? description;
  String? category;
  int? credit;
  List<Student>? students;

  EventDetailModel({
    this.eventId,
    this.eventName,
    this.eventPostDate,
    this.eventExpiryDate,
    this.eventSlotCount,
    this.sessionCount,
    this.eventFee,
    this.description,
    this.category,
    this.credit,
    this.students,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return _$EventDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);
}
