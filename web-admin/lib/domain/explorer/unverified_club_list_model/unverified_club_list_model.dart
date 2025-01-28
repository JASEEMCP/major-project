import 'package:json_annotation/json_annotation.dart';

part 'unverified_club_list_model.g.dart';

@JsonSerializable()
class UnverifiedClubListModel {
  @JsonKey(name: 'authority_id')
  String? authorityId;
  @JsonKey(name: 'authority_name')
  String? authorityName;
  String? email;
  @JsonKey(name: 'author_name')
  String? authorName;

  UnverifiedClubListModel({
    this.authorityId,
    this.authorityName,
    this.email,
    this.authorName,
  });

  factory UnverifiedClubListModel.fromJson(Map<String, dynamic> json) {
    return _$UnverifiedClubListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UnverifiedClubListModelToJson(this);
}
