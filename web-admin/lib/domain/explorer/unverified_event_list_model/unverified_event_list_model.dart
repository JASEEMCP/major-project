import 'package:json_annotation/json_annotation.dart';

import 'authority.dart';
import 'category.dart';

part 'unverified_event_list_model.g.dart';

@JsonSerializable()
class UnverifiedEventListModel {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_fee')
  int? eventFee;
  String? description;
  @JsonKey(name: 'session_count')
  int? sessionCount;
  Category? category;
  Authority? authority;

  UnverifiedEventListModel({
    this.eventId,
    this.eventName,
    this.eventFee,
    this.description,
    this.sessionCount,
    this.category,
    this.authority,
  });

  factory UnverifiedEventListModel.fromJson(Map<String, dynamic> json) {
    return _$UnverifiedEventListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnverifiedEventListModelToJson(this);
}
