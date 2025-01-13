part of 'token_cubit.dart';

@freezed
class TokenState with _$TokenState {
  const factory TokenState.initial() = _Initial;
  const factory TokenState.authorized(Token? token) = _Authorized;
}

extension TokenStateX on TokenState {
  // String? get accessToken =>
  //     maybeWhen(authorized: () => token.accessToken, orElse: () => null);
  // String? get refreshToken =>
  //     maybeWhen(authorized: () => token.refreshToken, orElse: () => null);

  ///getting value user authenticated or not
  bool get isAuthenticated => when(
        initial: () => false,
        authorized: (_) => true,
      );

  ///Assign value to header
  Map<String, String> toAuthorizationHeader() => maybeWhen(
        authorized: (t) => {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${t?.accessToken}",
        },
        orElse: () => {
          'Content-Type': 'application/json',
        },
      );
}
