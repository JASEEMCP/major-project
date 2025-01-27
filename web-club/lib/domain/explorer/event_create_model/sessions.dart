import 'package:json_annotation/json_annotation.dart';

part 'sessions.g.dart';

@JsonSerializable()
class Sessions {
  String? date;
  @JsonKey(name: 'event_start_time')
  String? eventStartTime;
  @JsonKey(name: 'event_end_time')
  String? eventEndTime;
  @JsonKey(name: 'faculty_name')
  String? facultyName;
  @JsonKey(name: 'Venue')
  String? venue;

  Sessions({
    this.date,
    this.eventStartTime,
    this.eventEndTime,
    this.facultyName,
    this.venue,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    return _$SessionsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SessionsToJson(this);

  Sessions copyWith({
    String? date,
    String? eventStartTime,
    String? eventEndTime,
    String? facultyName,
    String? venue,
  }) {
    return Sessions(
      date: date ?? this.date,
      eventStartTime: eventStartTime ?? this.eventStartTime,
      eventEndTime: eventEndTime ?? this.eventEndTime,
      facultyName: facultyName ?? this.facultyName,
      venue: venue ?? this.venue,
    );
  }
}
