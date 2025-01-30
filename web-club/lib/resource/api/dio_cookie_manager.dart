// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:app/infrastructure/env/env.dart';
import 'package:dio/dio.dart';

class DioCookieManger {
  final _dio = Dio();

  DioCookieManger() {
    _dio.options = BaseOptions(
      baseUrl: Env().apiBaseUrl,
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'X-CSRFToken': getCookie('csrftoken'),
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'cookie': getCookie('cookie')
      },
    );

    _dio.interceptors.add(WebCookieManager());
  }

  Dio get dio => _dio;
}

class WebCookieManager extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? cookies = html.document.cookie;

    if (cookies != null) {
      options.headers['cookie'] = cookies;
    }
    // String? csrfToken = getCsrfToken();
    // if (csrfToken != null) {
    //   options.headers['X-CSRF-Token'] = csrfToken;
    // }
    options.extra['withCredentials'] = true;
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    List<String>? setCookies = response.headers['Set-Cookie'];
    if (setCookies != null) {
      for (var setCookie in setCookies) {
        html.document.cookie = setCookie;
      }
    }
    handler.next(response);
  }
}

String? getCookie(String name) {
  var cookies = html.document.cookie?.split(';') ?? [];
  for (var cookie in cookies) {
    var keyValue = cookie.split('=');
    if (keyValue[0].trim() == name) {
      return keyValue[1];
    }
  }
  return null;
}
