import 'package:app/infrastructure/env/env.dart';
import 'package:app/resource/api/cookie_manager_io.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioCookieManger {
  final _dio = Dio();
  final cookieJar = CookieJar();

  DioCookieManger() {
    _dio.options = BaseOptions(
      baseUrl: Env().apiBaseUrl,
      receiveTimeout: const Duration(seconds: 50),
      connectTimeout: const Duration(seconds: 50),
      sendTimeout: const Duration(seconds: 50),
    );
    // _dio.interceptors.add(
    //     // kIsWeb ? CookieManagerWeb(cookieJar) :
    //     CookieManagerIo(cookieJar));
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  Dio get dio => _dio;
}
