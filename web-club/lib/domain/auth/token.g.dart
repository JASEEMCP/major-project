// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      refreshToken: json['refresh_token'] as String?,
      accessToken: json['access_token'] as String?,
      isProfileCreated: json['is_profile_created'] as bool?,
      name: json['name'] as String?,
      userType: json['user_type'] as String?,
      isVerified: json['is_verified'] as bool?,
      profileId: json['profile_id'] as String?,
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'refresh_token': instance.refreshToken,
      'access_token': instance.accessToken,
      'is_profile_created': instance.isProfileCreated,
      'user_type': instance.userType,
      'name': instance.name,
      'is_verified': instance.isVerified,
      'profile_id': instance.profileId,
    };
