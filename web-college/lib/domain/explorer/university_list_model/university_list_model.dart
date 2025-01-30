import 'package:json_annotation/json_annotation.dart';

part 'university_list_model.g.dart';

@JsonSerializable()
class UniversityListModel {
  @JsonKey(name: 'university_id')
  String? universityId;
  String? name;

  UniversityListModel({this.universityId, this.name});

  factory UniversityListModel.fromJson(Map<String, dynamic> json) {
    return _$UniversityListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UniversityListModelToJson(this);
}
