import 'package:json_annotation/json_annotation.dart';

part 'club_profile_model.g.dart';

@JsonSerializable()
class ClubProfileModel {
  @JsonKey(name: 'authority_name')
  String? authorityName;
  @JsonKey(name: 'club_email')
  String? clubEmail;
  @JsonKey(name: 'author_name')
  String? authorName;

  ClubProfileModel({this.authorityName, this.clubEmail, this.authorName});

  factory ClubProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ClubProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClubProfileModelToJson(this);

  ClubProfileModel copyWith({
    String? authorityName,
    String? clubEmail,
    String? authorName,
  }) {
    return ClubProfileModel(
      authorityName: authorityName ?? this.authorityName,
      clubEmail: clubEmail ?? this.clubEmail,
      authorName: authorName ?? this.authorName,
    );
  }
}
