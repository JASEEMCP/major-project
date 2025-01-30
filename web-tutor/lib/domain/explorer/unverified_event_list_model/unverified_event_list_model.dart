import 'package:json_annotation/json_annotation.dart';

part 'unverified_event_list_model.g.dart';

@JsonSerializable()
class UnverifiedEventListModel {
  @JsonKey(name: 'event_id')
  String? eventId;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_post_date')
  String? eventPostDate;
  @JsonKey(name: 'registered_student_count')
  int? registeredStudentCount;

  UnverifiedEventListModel({
    this.eventId,
    this.eventName,
    this.eventPostDate,
    this.registeredStudentCount,
  });

  factory UnverifiedEventListModel.fromJson(Map<String, dynamic> json) {
    return _$UnverifiedEventListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnverifiedEventListModelToJson(this);
}
