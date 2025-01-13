import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'is_profile_created')
  bool? isProfileCreated;
  @JsonKey(name: 'user_type')
  String? userType;
  String? name;

  Token({
    this.refreshToken,
    this.accessToken,
    this.isProfileCreated,
    this.name,
    this.userType,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  Token copyWith({
    String? refreshToken,
    String? accessToken,
    bool? isProfileCreated,
    String? name,
    String? userType,
  }) {
    return Token(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      isProfileCreated: isProfileCreated ?? this.isProfileCreated,
      name: name ?? this.name,
      userType: userType ?? this.userType,
    );
  }
}
