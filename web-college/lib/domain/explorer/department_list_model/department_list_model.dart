import 'package:json_annotation/json_annotation.dart';

part 'department_list_model.g.dart';

@JsonSerializable()
class DepartmentListModel {
  @JsonKey(name: 'department_id')
  String? departmentId;
  String? name;
  int? strength;
  @JsonKey(name: 'short_name')
  String? shortName;

  DepartmentListModel({
    this.departmentId,
    this.name,
    this.strength,
    this.shortName,
  });

  factory DepartmentListModel.fromJson(Map<String, dynamic> json) {
    return _$DepartmentListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentListModelToJson(this);
}
