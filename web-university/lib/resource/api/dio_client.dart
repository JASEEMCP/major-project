import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:app/application/auth/token_cubit/token_cubit.dart';
import 'package:app/infrastructure/env/env.dart';
import 'package:app/main.dart';

enum DioMethodType { get, post, put, delete }

@lazySingleton
class DioClient {
  late final Dio _dio = Dio();
  int refreshLimit = 0;

  late StreamSubscription tokenCubitSubscription;
  TokenCubit tokenCubit;
  DioClient(this.tokenCubit) {
    ///Assign base option values
    _dio.options = BaseOptions(
      baseUrl: Env().apiBaseUrl,
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(tokenCubit.state);
          _dio.options.headers = tokenCubit.state.toAuthorizationHeader();

          /// Check if tokens are valid before making the request
          if (!areTokensValid()) {
            /// Prevent the request if tokens are invalid
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.cancel,
                error: 'Tokens are invalid',
              ),
            );
          }
          handler.next(options); // Continue with the request
        },
        onError: (e, handler) async {
          if (e.type == DioExceptionType.connectionError) {
            return handler.reject(e);
          }

          ///Handle Unauthorized exception
          if (tokenCubit.state.isAuthenticated &&
              e.response?.statusCode == 401) {
            if (e.response != null) {
              final result = await tokenCubit.refreshToken();

              if (result != null) {
                addToken(dio, tokenCubit.state);
                final opts = Options(method: e.requestOptions.method);
                final response = await _dio.request(
                  e.requestOptions.path,
                  options: opts,
                  cancelToken: e.requestOptions.cancelToken,
                  onReceiveProgress: e.requestOptions.onReceiveProgress,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
                );
                handler.resolve(response);
              }
            }
          } else {
            handler.reject(e);
          }
        },
      ),
    );

    /// Add token header value at the beginning of app
    if (tokenCubit.state.isAuthenticated) {
      addToken(_dio, tokenCubit.state);
    }

    /// Listen token cubit and assign header value with corresponding TokenState
    tokenCubitSubscription = tokenCubit.stream.listen(
      (event) {
        if (!event.isAuthenticated) {
          addToken(_dio, tokenCubit.state);
        }
      },
    );
  }

  Dio get dio => _dio;

  void dispose() {
    tokenCubitSubscription.cancel();
  }

  void addToken(Dio dio, TokenState state) {
    dio.options.headers.addAll(state.toAuthorizationHeader());
  }

  // void _handleExit() {
  //   /// Implement your logic to exit the app or redirect to login
  //   /// For example, you can navigate to a login page
  //   appRouter.go(ScreenPath.login);
  // }

  bool areTokensValid() {
    final refreshToken = pref.token.value.refreshToken ?? '';
    final accessToken = pref.token.value.accessToken ?? '';
    return refreshToken.isNotEmpty && accessToken.isNotEmpty;
  }
}
