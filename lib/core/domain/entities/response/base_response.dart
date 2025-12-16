import 'package:equatable/equatable.dart';

class BaseResponse<T> extends Equatable {
  final String statusCode;
  final String responseDatetime;
  final T? result;
  final String message;
  final bool success;

  const BaseResponse({
    this.statusCode = '',
    this.responseDatetime = '',
    this.result,
    this.message = '',
    this.success = false,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) jsonDynamic,
  ) {
    final dynamic resultJson = json['result'] ?? {};
    late T? result;

    if (resultJson is String) {
      result = resultJson as T;
    } else if (resultJson is int) {
      result = resultJson as T;
    } else if (resultJson is double) {
      result = resultJson as T;
    } else if (resultJson is bool) {
      result = resultJson as T;
    } else if (resultJson is Map<String, dynamic>) {
      result = jsonDynamic(resultJson);
    } else {
      result = null;
    }

    return BaseResponse(
      statusCode: json['statusCode'] ?? '',
      responseDatetime: json['responseDatetime'] ?? '',
      result: result,
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  @override
  String toString() => 'BaseResponse('
      'statusCode: $statusCode, '
      'responseDatetime: $responseDatetime, '
      'result: $result, '
      'message: $message, '
      'success: $success'
      ')';

  @override
  List<Object?> get props => [
        statusCode,
        responseDatetime,
        result,
        message,
        success,
      ];
}