import 'dart:async';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

class CookieManagerIo extends Interceptor {
  const CookieManagerIo(this.cookieJar);

  final CookieJar cookieJar;

  static String getCookies(List<Cookie> cookies) {
    cookies.sort((a, b) {
      if (a.path == null && b.path == null) {
        return 0;
      } else if (a.path == null) {
        return -1;
      } else if (b.path == null) {
        return 1;
      } else {
        return b.path!.length.compareTo(a.path!.length);
      }
    });
    return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    cookieJar.loadForRequest(options.uri).then((cookies) {
      final previousCookies =
          options.headers[HttpHeaders.cookieHeader] as String?;
      final newCookies = getCookies([
        ...?previousCookies
            ?.split(';')
            .where((e) => e.isNotEmpty)
            .map((c) => Cookie.fromSetCookieValue(c)),
        ...cookies,
      ]);
      options.headers[HttpHeaders.cookieHeader] =
          newCookies.isNotEmpty ? newCookies : null;
      handler.next(options);
    }).catchError((dynamic e, StackTrace s) {
      final err = DioException(
        requestOptions: options,
        error: e,
        stackTrace: s,
      );
      handler.reject(err, true);
    });
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _saveCookies(response).then((_) => handler.next(response)).catchError(
      (dynamic e, StackTrace s) {
        final err = DioException(
          requestOptions: response.requestOptions,
          error: e,
          stackTrace: s,
        );
        handler.reject(err, true);
      },
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      _saveCookies(err.response!).then((_) => handler.next(err)).catchError(
        (dynamic e, StackTrace s) {
          final error = DioException(
            requestOptions: err.response!.requestOptions,
            error: e,
            stackTrace: s,
          );
          handler.next(error);
        },
      );
    } else {
      handler.next(err);
    }
  }

  Future<void> _saveCookies(Response response) async {
    final setCookies = response.headers[HttpHeaders.setCookieHeader];
    if (setCookies == null || setCookies.isEmpty) {
      return;
    }
    final List<Cookie> cookies = setCookies
        .map((str) => str.split(RegExp('(?<=)(,)(?=[^;]+?=)')))
        .expand((cookie) => cookie)
        .where((cookie) => cookie.isNotEmpty)
        .map((str) => Cookie.fromSetCookieValue(str))
        .toList();

    final statusCode = response.statusCode ?? 0;
    final locations = response.headers[HttpHeaders.locationHeader] ?? [];
    final isRedirectRequest = statusCode >= 300 && statusCode < 400;
    final originalUri = response.requestOptions.uri;
    final realUri = originalUri.resolveUri(response.realUri);
    await cookieJar.saveFromResponse(realUri, cookies);
    if (isRedirectRequest && locations.isNotEmpty) {
      final originalUri = response.realUri;
      await Future.wait(
        locations.map(
          (location) => cookieJar.saveFromResponse(
            originalUri.resolve(location),
            cookies,
          ),
        ),
      );
    }
  }
}
