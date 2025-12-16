import 'package:equatable/equatable.dart';

class BaseResponseV1<T> extends Equatable {
  final String responseCode;
  final String responseDatetime;
  final String partnerReferenceNo;
  final String referenceNo;
  final T? result;
  final String responseMessage;

  const BaseResponseV1({
    this.responseCode = '',
    this.responseDatetime = '',
    this.partnerReferenceNo = '',
    this.referenceNo = '',
    this.result,
    this.responseMessage = '',
  });

  factory BaseResponseV1.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? jsonDynamic,
  ) {
    final dynamic resultJson = json['result'];
    T? result;

    if (resultJson == null) {
      result = null;
    } else if (resultJson is String) {
      result = resultJson as T;
    } else if (resultJson is int) {
      result = resultJson as T;
    } else if (resultJson is double) {
      result = resultJson as T;
    } else if (resultJson is bool) {
      result = resultJson as T;
    } else if (resultJson is Map<String, dynamic> && jsonDynamic != null) {
      result = jsonDynamic(resultJson);
    } else {
      result = null;
    }

    return BaseResponseV1<T>(
      responseCode: json['responseCode'] ?? '',
      responseDatetime: json['responseDatetime'] ?? '',
      partnerReferenceNo: json['partnerReferenceNo'] ?? '',
      referenceNo: json['referenceNo'] ?? '',
      result: result,
      responseMessage: json['responseMessage'] ?? '',
    );
  }

  BaseResponseV1<T> copyWith({
    String? responseCode,
    String? responseDatetime,
    String? partnerReferenceNo,
    String? referenceNo,
    T? result,
    String? responseMessage,
  }) {
    return BaseResponseV1<T>(
      responseCode: responseCode ?? this.responseCode,
      responseDatetime: responseDatetime ?? this.responseDatetime,
      partnerReferenceNo: partnerReferenceNo ?? this.partnerReferenceNo,
      referenceNo: referenceNo ?? this.referenceNo,
      result: result ?? this.result,
      responseMessage: responseMessage ?? this.responseMessage,
    );
  }

  @override
  String toString() {
    return 'BaseResponse('
        'responseCode: $responseCode, '
        'responseDatetime: $responseDatetime, '
        'partnerReferenceNo: $partnerReferenceNo, '
        'referenceNo: $referenceNo, '
        'result: $result, '
        'responseMessage: $responseMessage)';
  }

  @override
  List<Object?> get props => [
        responseCode,
        responseDatetime,
        partnerReferenceNo,
        referenceNo,
        result,
        responseMessage,
      ];
}