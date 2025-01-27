import 'package:json_annotation/json_annotation.dart';

import 'sessions.dart';

part 'event_create_model.g.dart';

@JsonSerializable()
class EventCreateModel {
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
  Sessions? sessions;

  EventCreateModel({
    this.eventName,
    this.eventPostDate,
    this.eventExpiryDate,
    this.eventSlotCount,
    this.sessionCount,
    this.eventFee,
    this.description,
    this.category,
    this.sessions,
  });

  factory EventCreateModel.fromJson(Map<String, dynamic> json) {
    return _$EventCreateModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventCreateModelToJson(this);

  EventCreateModel copyWith({
    String? eventName,
    String? eventPostDate,
    String? eventExpiryDate,
    int? eventSlotCount,
    int? sessionCount,
    int? eventFee,
    String? description,
    String? category,
    Sessions? sessions,
  }) {
    return EventCreateModel(
      eventName: eventName ?? this.eventName,
      eventPostDate: eventPostDate ?? this.eventPostDate,
      eventExpiryDate: eventExpiryDate ?? this.eventExpiryDate,
      eventSlotCount: eventSlotCount ?? this.eventSlotCount,
      sessionCount: sessionCount ?? this.sessionCount,
      eventFee: eventFee ?? this.eventFee,
      description: description ?? this.description,
      category: category ?? this.category,
      sessions: sessions ?? this.sessions,
    );
  }
}
