// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeProfileModel _$CollegeProfileModelFromJson(Map<String, dynamic> json) =>
    CollegeProfileModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phone_no'] as String?,
      address: json['address'] as String?,
      website: json['website'] as String?,
      type: json['type'] as String?,
      shortName: json['short_name'] as String?,
      principalName: json['principal_name'] as String?,
    );

Map<String, dynamic> _$CollegeProfileModelToJson(
        CollegeProfileModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone_no': instance.phoneNo,
      'address': instance.address,
      'website': instance.website,
      'type': instance.type,
      'short_name': instance.shortName,
      'principal_name': instance.principalName,
    };
