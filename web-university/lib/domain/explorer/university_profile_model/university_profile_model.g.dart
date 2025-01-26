// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityProfileModel _$UniversityProfileModelFromJson(
        Map<String, dynamic> json) =>
    UniversityProfileModel(
      name: json['name'] as String?,
      address: json['address'] as String?,
      phoneNo: json['phone_no'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$UniversityProfileModelToJson(
        UniversityProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'phone_no': instance.phoneNo,
      'email': instance.email,
      'website': instance.website,
      'short_name': instance.shortName,
    };
