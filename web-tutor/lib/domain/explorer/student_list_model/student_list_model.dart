import 'package:json_annotation/json_annotation.dart';

part 'student_list_model.g.dart';

@JsonSerializable()
class StudentListModel {
  @JsonKey(name: 'student_id')
  String? studentId;
  String? name;
  @JsonKey(name: 'register_no')
  String? registerNo;
  String? department;

  StudentListModel({
    this.studentId,
    this.name,
    this.registerNo,
    this.department,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> json) {
    return _$StudentListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StudentListModelToJson(this);
}
