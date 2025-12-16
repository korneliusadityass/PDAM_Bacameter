import 'package:equatable/equatable.dart';

class BaseValueResponse<T> extends Equatable {
  final String statusCode;
  final String responseDatetime;
  final T? result;
  final String message;

  const BaseValueResponse({
    this.statusCode = '',
    this.responseDatetime = '',
    this.result,
    this.message = '',
  });

  factory BaseValueResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) jsonDynamic,
  ) {
    return BaseValueResponse(
      statusCode: json['statusCode'] ?? '',
      responseDatetime: json['responseDatetime'] ?? '',
      result: (json['result'] is String)
          ? int.tryParse(json['result']) as T?
          : int.tryParse('0') as T?,
      message: json['message'] ?? '',
    );
  }

  @override
  String toString() => 'BaseValueResponse('
      'statusCode: $statusCode, '
      'responseDatetime: $responseDatetime, '
      'result: $result, '
      'message: $message'
      ')';

  @override
  List<Object?> get props => [
        statusCode,
        responseDatetime,
        result,
        message,
      ];
}