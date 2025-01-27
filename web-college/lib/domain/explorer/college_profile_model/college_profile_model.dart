import 'package:json_annotation/json_annotation.dart';

part 'college_profile_model.g.dart';

@JsonSerializable()
class CollegeProfileModel {
  String? name;
  String? email;
  @JsonKey(name: 'phone_no')
  String? phoneNo;
  String? address;
  String? website;
  String? type;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'principal_name')
  String? principalName;

  CollegeProfileModel({
    this.name,
    this.email,
    this.phoneNo,
    this.address,
    this.website,
    this.type,
    this.shortName,
    this.principalName,
  });

  factory CollegeProfileModel.fromJson(Map<String, dynamic> json) {
    return _$CollegeProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollegeProfileModelToJson(this);
}
