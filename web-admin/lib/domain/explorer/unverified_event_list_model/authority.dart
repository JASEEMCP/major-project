import 'package:json_annotation/json_annotation.dart';

part 'authority.g.dart';

@JsonSerializable()
class Authority {
  @JsonKey(name: 'authority_id')
  String? authorityId;
  @JsonKey(name: 'authority_name')
  String? authorityName;
  @JsonKey(name: 'author_name')
  String? authorName;

  Authority({this.authorityId, this.authorityName, this.authorName});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return _$AuthorityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthorityToJson(this);
}
