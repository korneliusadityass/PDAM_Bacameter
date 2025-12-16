import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class AuthInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    dynamic responseData;

    // Check if the response is in bytes,
    if (response.data is List<int>) {
      super.onResponse(response, handler);
      return;
    }

    if (response.data is String) {
      try {
        responseData = jsonDecode(response.data);
      } catch (e) {
        debugPrint('Failed to decode JSON: $e');
        responseData = {};
      }
    } else {
      responseData = response.data ?? {};
    }

    final dynamic statusCode =
        responseData['responseCode'] ?? responseData['statusCode'] ?? '';
    final String message =
        responseData['message'] ?? responseData['responseMessage'] ?? '';

    if (statusCode is String && statusCode == '401') {
      debugPrint('onError: Status code detected as String');
      // _handleUnauthorizedLogout();
      return;
    }

    if (statusCode is int && statusCode == 401) {
      debugPrint('onError: Status code detected as int');
      // _handleUnauthorizedLogout();
      return;
    }

    // Handle if status code 400 but message is Unauthorized
    if (statusCode is String &&
        statusCode == '400' &&
        message == 'missing or malformed jwt') {
      // _handleUnauthorizedLogout();
      return;
    }

    if (statusCode is int &&
        statusCode == 400 &&
        message == 'missing or malformed jwt') {
      // _handleUnauthorizedLogout();
      return;
    }

    super.onResponse(response, handler);
  }

  // void _handleUnauthorizedLogout() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     final mContext = navigatorKey.currentContext;

  //     if (mContext != null) {
  //       // Close error dialog if exist
  //       if (mContext.canPop()) {
  //         mContext.popMultipleTimes(1);
  //       }

  //       showErrorDialogWithSingleAction(
  //         mContext,
  //         title: 'Sesi Anda Telah Habis',
  //         description: 'Silahkan login kembali untuk melanjutkan',
  //         canDismiss: false,
  //         positiveButton: 'Keluar',
  //         onPositivePressed: () {
  //           mContext.goNamed(Routes.login);
  //         },
  //       );

  //       await SharedPrefsHelper.logoutUser();
  //     }
  //   });
  // }
}