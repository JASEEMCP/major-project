import 'package:json_annotation/json_annotation.dart';

part 'event_list.g.dart';

@JsonSerializable()
class EventList {
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  @JsonKey(name: 'category_name')
  String? categoryName;
  String? authority;
  String? date;

  EventList({
    this.eventName,
    this.eventFee,
    this.categoryName,
    this.authority,
    this.date,
  });

  factory EventList.fromJson(Map<String, dynamic> json) {
    return _$EventListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EventListToJson(this);
}
