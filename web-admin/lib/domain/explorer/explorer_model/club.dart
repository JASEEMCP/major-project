import 'package:json_annotation/json_annotation.dart';

import 'event.dart';

part 'club.g.dart';

@JsonSerializable()
class Club {
  @JsonKey(name: 'authority_name')
  String? authorityName;
  @JsonKey(name: 'author_name')
  String? authorName;
  List<Event>? events;

  Club({this.authorityName, this.authorName, this.events});

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

  Map<String, dynamic> toJson() => _$ClubToJson(this);
}
