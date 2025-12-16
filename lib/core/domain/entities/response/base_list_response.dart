class BaseListResponse<T> {
  final String statusCode;
  final String responseCode;
  final String responseDatetime;
  final List<T>? result;
  final String message;

  const BaseListResponse({
    this.statusCode = '',
    this.responseCode = '',
    this.responseDatetime = '',
    this.result = const [],
    this.message = '',
  });

  factory BaseListResponse.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) fromJsonT) {
    return BaseListResponse<T>(
      statusCode: json['statusCode'] ?? '',
      responseCode: json['responseCode'] ?? '',
      message: json['message'] ?? '',
      result: (json['result'] as List<dynamic>?)
          ?.map<T>((item) => fromJsonT(item))
          .toList(),
      responseDatetime: json['responseDatetime'] ?? '',
    );
  }

  @override
  String toString() => 'BaseListResponse{'
      'statusCode: $statusCode, '
      'responseCode: $responseCode, '
      'responseDatetime: $responseDatetime, '
      'result: $result, '
      'message: $message'
      '}';

  Map<String, dynamic> toJson(T Function(T) toJsonT) {
    return {
      'statusCode': statusCode,
      'responseCode': responseCode,
      'responseDatetime': responseDatetime,
      'result': result?.map(toJsonT).toList(),
      'message': message,
    };
  }
}
