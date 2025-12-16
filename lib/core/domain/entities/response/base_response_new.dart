class BaseListResponseNew<T> {
  final String responseCode;
  final String responseDatetime;
  final T? result;
  final String responseMessage;

  const BaseListResponseNew({
    this.responseCode = '',
    this.responseDatetime = '',
    this.result,
    this.responseMessage = '',
  });

  factory BaseListResponseNew.fromJson(
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

    return BaseListResponseNew<T>(
      responseCode: json['responseCode'] ?? '',
      responseMessage: json['responseMessage'] ?? false,
      result: result,
      responseDatetime: json['responseDatetime'] ?? '',
    );
  }

  @override
  String toString() => 'BaseListResponseNew{'
      'responseCode: $responseCode, '
      'responseDatetime: $responseDatetime, '
      'result: $result, '
      'responseMessage: $responseMessage'
      '}';
}
