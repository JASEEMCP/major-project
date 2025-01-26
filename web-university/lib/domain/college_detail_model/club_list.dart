import 'package:json_annotation/json_annotation.dart';

part 'club_list.g.dart';

@JsonSerializable()
class ClubList {
  @JsonKey(name: 'authority_name')
  String? authorityName;
  @JsonKey(name: 'author_name')
  String? authorName;

  ClubList({this.authorityName, this.authorName});

  factory ClubList.fromJson(Map<String, dynamic> json) {
    return _$ClubListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClubListToJson(this);
}
