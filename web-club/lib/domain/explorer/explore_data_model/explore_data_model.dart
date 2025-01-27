import 'package:app/domain/explorer/event_detail_model/student.dart';
import 'package:json_annotation/json_annotation.dart';

part 'explore_data_model.g.dart';

@JsonSerializable()
class ExploreDataModel {
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

  ExploreDataModel({
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

  factory ExploreDataModel.fromJson(Map<String, dynamic> json) {
    return _$ExploreDataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExploreDataModelToJson(this);
}
