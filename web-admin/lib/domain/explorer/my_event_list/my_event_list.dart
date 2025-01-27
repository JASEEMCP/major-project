import 'package:json_annotation/json_annotation.dart';

part 'my_event_list.g.dart';

@JsonSerializable()
class MyEventList {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_date')
  String? eventDate;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  int? credit;
  String? category;

  MyEventList({
    this.eventId,
    this.eventName,
    this.eventDate,
    this.eventFee,
    this.credit,
    this.category,
  });

  factory MyEventList.fromJson(Map<String, dynamic> json) {
    return _$MyEventListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MyEventListToJson(this);
}
