class BaseRequest<T> {
  final String apiCode;
  final int apiVersion;
  final T request;

  BaseRequest({
    required this.apiCode,
    required this.apiVersion,
    required this.request,
  });

  @override
  String toString() {
    return 'BaseRequest('
        'apiCode: $apiCode, '
        'apiVersion: $apiVersion, '
        'request: $request'
        ')';
  }

  Map<String, dynamic> toJson() {
    return {
      'apiCode': apiCode,
      'apiVersion': apiVersion,
      'request': request,
    };
  }
}
