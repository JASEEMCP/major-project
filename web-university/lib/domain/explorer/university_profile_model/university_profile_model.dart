import 'package:json_annotation/json_annotation.dart';

part 'university_profile_model.g.dart';

@JsonSerializable()
class UniversityProfileModel {
  String? name;
  String? address;
  @JsonKey(name: 'phone_no')
  String? phoneNo;
  String? email;
  String? website;
  @JsonKey(name: 'short_name')
  String? shortName;

  UniversityProfileModel({
    this.name,
    this.address,
    this.phoneNo,
    this.email,
    this.website,
    this.shortName,
  });

  factory UniversityProfileModel.fromJson(Map<String, dynamic> json) {
    return _$UniversityProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UniversityProfileModelToJson(this);
}
