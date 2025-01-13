import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:app/domain/auth/token.dart';
import 'package:app/main.dart';


part 'token_state.dart';
part 'token_cubit.freezed.dart';

@lazySingleton
class TokenCubit extends Cubit<TokenState> {
  //final AuthService _authService;
  TokenCubit() : super(const TokenState.initial());

  Future<void> initTokenState() async {
    try {
      final rt = pref.token.value.refreshToken;
      // Checking token expire or not
      final isExpired = JwtDecoder.isExpired(rt ?? "");
      // Checking institute profile completed or not
      // final isProfileCompleted = pref.token.value.isSubmit ?? false;
      // if (!isExpired && isProfileCompleted) {
      //   emit(TokenState.authorized(pref.token.value));
      // } else {
      //   emit(const TokenState.initial());
      // }
    } catch (_) {
      emit(const TokenState.initial());
    }
  }

  updateToken(Token? t) {
    emit(TokenState.authorized(t));
  }

  logoutUser() {
    emit(const TokenState.initial());
  }

  Future<String?> refreshToken() async {
    //final r = await _authService.refreshToken();
    // return r.fold(
    //   (e) {
    //     pref.token.value = pref.token.value.copyWith(
    //       accessToken: null,
    //       refreshToken: null,
    //       isProfileCreated: false,
    //       fullName: null,
    //       isSubmit: false,
    //       instituteFullName: null,
    //       instituteShortName: null,
    //     );
    //     appRouter.go(ScreenPath.login);
    //     emit(const TokenState.initial());

        return null;
    //   },
    //   (token) {
    //     emit(TokenState.authorized(token));
    //     return token.accessToken;
    //   },
    // );
  }
}
