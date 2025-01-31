import 'package:json_annotation/json_annotation.dart';

part 'recent_event_list_model.g.dart';

@JsonSerializable()
class RecentEventListModel {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_post_date')
  String? eventPostDate;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  @JsonKey(name: 'event_slot_count')
  int? eventSlotCount;

  RecentEventListModel({
    this.eventId,
    this.eventName,
    this.eventPostDate,
    this.eventFee,
    this.eventSlotCount,
  });

  factory RecentEventListModel.fromJson(Map<String, dynamic> json) {
    return _$RecentEventListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RecentEventListModelToJson(this);
}
