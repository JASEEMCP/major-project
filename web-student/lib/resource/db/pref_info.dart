import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:app/domain/auth/token.dart';
import 'package:app/resource/db/load_and_save.dart';

@LazySingleton()
class PrefInfo with LoadAndSaveMixin {
  late final token = ValueNotifier<Token>(
    Token(
      accessToken: null,
      refreshToken: null,
      isProfileCreated: false,
      name: null,
      userType: null,
      profileId: null,
      isVerified: false,
    ),
  )..addListener(save);

  @override
  void copyFromJson(Map<String, dynamic> data) {
    token.value.accessToken = data['access_token'] ?? '';
    token.value.refreshToken = data['refresh_token'] ?? '';
    token.value.isProfileCreated = data['is_profile_created'] ?? false;
    token.value.name = data['name'] ?? '';
    token.value.userType = data['user_type'] ?? '';
    token.value.isVerified = data['is_verified'] ?? false;
    token.value.profileId = data['profile_id'] ?? '';
  }

  @override
  String get fileName => 'info.dat';

  @override
  Map<String, dynamic> toJson() {
    return {
      'access_token': token.value.accessToken,
      'refresh_token': token.value.refreshToken,
      'name': token.value.name,
      'user_type': token.value.userType,
      'is_profile_created': token.value.isProfileCreated,
      'is_verified': token.value.isVerified,
      'profile_id': token.value.profileId,
    };
  }
}
