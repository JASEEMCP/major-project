import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_date')
  String? eventDate;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  String? description;
  @JsonKey(name: 'organization_name')
  dynamic organizationName;

  Event({
    this.eventName,
    this.eventDate,
    this.eventFee,
    this.description,
    this.organizationName,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
