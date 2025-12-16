import 'package:equatable/equatable.dart';

class BaseResponseV1List<T> extends Equatable {
  final String responseCode;
  final String responseDatetime;
  final String partnerReferenceNo;
  final String referenceNo;
  final List<T>? result;
  final String responseMessage;

  const BaseResponseV1List({
    this.responseCode = '',
    this.responseDatetime = '',
    this.partnerReferenceNo = '',
    this.referenceNo = '',
    this.result,
    this.responseMessage = '',
  });

  factory BaseResponseV1List.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json)? jsonDynamic,
  ) {
    return BaseResponseV1List<T>(
      responseCode: json['responseCode'] ?? '',
      responseDatetime: json['responseDatetime'] ?? '',
      partnerReferenceNo: json['partnerReferenceNo'] ?? '',
      referenceNo: json['referenceNo'] ?? '',
      result: json['result'] != null
          ? (json['result'] as List<dynamic>)
              .map((item) => jsonDynamic!(item))
              .toList()
          : [],
      responseMessage: json['responseMessage'] ?? '',
    );
  }

  BaseResponseV1List<T> copyWith({
    String? responseCode,
    String? responseDatetime,
    String? partnerReferenceNo,
    String? referenceNo,
    List<T>? result,
    String? responseMessage,
  }) {
    return BaseResponseV1List<T>(
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
    return 'BaseResponseV1List('
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
