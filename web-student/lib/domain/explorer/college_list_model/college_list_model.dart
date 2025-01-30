import 'package:json_annotation/json_annotation.dart';

part 'college_list_model.g.dart';

@JsonSerializable()
class CollegeListModel {
  @JsonKey(name: 'college_id')
  String? collegeId;
  String? name;

  CollegeListModel({this.collegeId, this.name});

  factory CollegeListModel.fromJson(Map<String, dynamic> json) {
    return _$CollegeListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollegeListModelToJson(this);
}
