import 'dart:io';

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioExceptionType.unknown:
        if (dioError.error.toString().contains('SocketException')) {
          message = 'No Internet Connection';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      case DioExceptionType.connectionError:
        if (dioError.error is SocketException) {
          message = 'No Internet Connection. Please check your network.';
        } else {
          message = 'Failed to connect to the server.';
        }
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error['message'];
      case 401:
        return error['message'];
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 422:
        return error['message'];
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
