
import 'package:app/domain/explorer/college_detail_model/student_list/student_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';

@JsonSerializable()
class Department {
  String? name;
  int? strength;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'student_list')
  List<StudentList>? studentList;

  Department({this.name, this.strength, this.shortName, this.studentList});

  factory Department.fromJson(Map<String, dynamic> json) {
    return _$DepartmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}
