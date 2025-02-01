import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  @JsonKey(name: 'event_session_id')
  String? eventSessionId;
  String? date;
  String? time;
  String? venue;
  @JsonKey(name: 'faculty_name')
  String? facultyName;
  @JsonKey(name: 'is_current_session')
  bool? isCurrentSession;
  int? index;

  Session({
    this.eventSessionId,
    this.date,
    this.time,
    this.venue,
    this.facultyName,
    this.isCurrentSession,
    this.index,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return _$SessionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
