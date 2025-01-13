import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'access_token')
  String? accessToken;
  

  Token({
    this.refreshToken,
    this.accessToken,
    
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  Token copyWith(
      {String? refreshToken,
      String? accessToken,
      bool? isProfileCreated,
      String? fullName,
      String? instituteFullName,
      String? instituteShortName,
      bool? isSubmit}) {
    return Token(
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      
    );
  }
}
