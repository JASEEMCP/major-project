// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeDetailModel _$CollegeDetailModelFromJson(Map<String, dynamic> json) =>
    CollegeDetailModel(
      collegeId: json['college_id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      principleName: json['principal_name'] as String?,
      phoneNo: json['phone_no'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      shortName: json['short_name'] as String?,
      eventList: (json['event_list'] as List<dynamic>?)
          ?.map((e) => EventList.fromJson(e as Map<String, dynamic>))
          .toList(),
      department: (json['department'] as List<dynamic>?)
          ?.map((e) => Department.fromJson(e as Map<String, dynamic>))
          .toList(),
      clubList: (json['club_list'] as List<dynamic>?)
          ?.map((e) => ClubList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollegeDetailModelToJson(CollegeDetailModel instance) =>
    <String, dynamic>{
      'college_id': instance.collegeId,
      'name': instance.name,
      'address': instance.address,
      'principal_name': instance.principleName,
      'phone_no': instance.phoneNo,
      'email': instance.email,
      'website': instance.website,
      'short_name': instance.shortName,
      'event_list': instance.eventList,
      'department': instance.department,
      'club_list': instance.clubList,
    };
