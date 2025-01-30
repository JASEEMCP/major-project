import 'package:json_annotation/json_annotation.dart';

import 'club_list.dart';
import 'department.dart';
import 'event_list.dart';

part 'college_detail_model.g.dart';

@JsonSerializable()
class CollegeDetailModel {
  @JsonKey(name: 'college_id')
  String? collegeId;
  String? name;
  String? address;
  @JsonKey(name: 'principal_name')
  String? principleName;
  @JsonKey(name: 'phone_no')
  String? phoneNo;
  String? email;
  String? website;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'event_list')
  List<EventList>? eventList;
  List<Department>? department;
  @JsonKey(name: 'club_list')
  List<ClubList>? clubList;

  CollegeDetailModel({
    this.collegeId,
    this.name,
    this.address,
    this.principleName,
    this.phoneNo,
    this.email,
    this.website,
    this.shortName,
    this.eventList,
    this.department,
    this.clubList,
  });

  factory CollegeDetailModel.fromJson(Map<String, dynamic> json) {
    return _$CollegeDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollegeDetailModelToJson(this);
}
