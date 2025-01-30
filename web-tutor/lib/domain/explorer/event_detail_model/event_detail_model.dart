import 'package:json_annotation/json_annotation.dart';

import 'student.dart';

part 'event_detail_model.g.dart';

@JsonSerializable()
class EventDetailModel {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  String? description;
  @JsonKey(name: 'event_date')
  String? eventDate;
  @JsonKey(name: 'event_slot_count')
  int? eventSlotCount;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  String? authority;
  int? credit;
  String? category;
  List<Student>? students;

  EventDetailModel({
    this.eventId,
    this.eventName,
    this.description,
    this.eventDate,
    this.eventSlotCount,
    this.eventFee,
    this.authority,
    this.credit,
    this.category,
    this.students,
  });

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return _$EventDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventDetailModelToJson(this);
}
