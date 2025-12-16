import 'package:baca_meter/core/data/utilities/network/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHandler {
  late SharedPreferences sharedPreferences;

  DioHandler({
    required this.sharedPreferences,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${dotenv.env['MINT_HEADER_BASIC_AUTH_USERNAME']}',
      },
    );
    final dio = Dio(options);
    dio.interceptors.add(AuthInterceptor());

    // Only show log in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (logData) {
            final log = logData.toString();
            _formattedLog(log);
          },
        ),
      );
      // dio.interceptors.add(ChuckerDioInterceptor());
    }

    return dio;
  }

  void _formattedLog(String log) {
    const maxLength = 1024;
    const divider = '---';

    final isRequest = log.startsWith('*** Request ***');
    final isResponse = log.startsWith('*** Response ***');

    if (isRequest || isResponse) {
      debugPrint(divider * 30);
    }

    if (log.length > maxLength) {
      int start = 0;
      while (start < log.length) {
        final end =
            (start + maxLength < log.length) ? start + maxLength : log.length;
        final chunk = log.substring(start, end);
        debugPrint(chunk);
        start = end;
      }
    } else {
      debugPrint(log);
    }

    if (isRequest || isResponse) {
      debugPrint(divider * 30);
    }
  }
}