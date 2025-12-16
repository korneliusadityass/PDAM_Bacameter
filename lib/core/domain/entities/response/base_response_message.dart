import 'package:equatable/equatable.dart';

class BaseResponseMessage extends Equatable {
  final String en;
  final String id;

  const BaseResponseMessage({
    this.en = '',
    this.id = '',
  });

  factory BaseResponseMessage.fromJson(Map<String, dynamic> json) =>
      BaseResponseMessage(
        en: json['en'] ?? '',
        id: json['id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'id': id,
      };

  @override
  String toString() => 'BaseResponseMessage(en: $en, id: $id)';

  @override
  List<Object?> get props => [en, id];
}
