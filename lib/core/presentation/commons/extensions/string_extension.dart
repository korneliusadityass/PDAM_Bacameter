import 'dart:convert';

import 'package:intl/intl.dart';


extension EmailValidator on String {
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
}

extension PhoneNumberValidator on String {
  bool get isValidPhoneNumber {
    final phoneNumberRegex = RegExp(
      r'^[0-9]{8,15}$',
    );
    return phoneNumberRegex.hasMatch(this);
  }

  String sanitizePhoneNumber() {
    return replaceAll(RegExp(r'\D'), '');
  }
}

extension TitleCase on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '')
        .join(' ');
  }
}

extension CurrencyFormat on String {
  String toCurrency() {
    final reversed = split('').reversed.toList();
    for (var i = 3; i < reversed.length; i += 4) {
      reversed.insert(i, '.');
    }
    return reversed.reversed.join('');
  }

  String toCurrencyWithRp() {
    final reversed = split('').reversed.toList();
    for (var i = 3; i < reversed.length; i += 4) {
      reversed.insert(i, '.');
    }
    return 'Rp${reversed.reversed.join('')}';
  }

  int removeCurrencyFormatAndParse() {
    final String removedFormat = replaceAll('Rp', '').replaceAll('.', '');
    return int.tryParse(removedFormat) ?? 0;
  }

  String formatVirtualAccount() =>
      replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
}

extension ProductPrice on String {
  String getProductNameFromPrice() {
    return replaceAll(RegExp(r'\D'), '');
  }
}

extension DateTimeFormatting on String {
  String toFormattedDate() {
    final DateTime date =
        DateTime.parse(this).toUtc().add(const Duration(hours: 7));
    final String month = _getMonthName(date.month);
    return '${date.day} $month ${date.year} ${date.hour.toString().padLeft(2, '0')}'
        ':${date.minute.toString().padLeft(2, '0')}';
  }

  String toFormattedTimeOnly() {
    final DateTime date =
        DateTime.parse(this).toUtc().add(const Duration(hours: 7));
    return '${date.hour.toString().padLeft(2, '0')}'
        ':${date.minute.toString().padLeft(2, '0')}'
        ':${date.second.toString().padLeft(2, '0')}';
  }

  String toFormattedDateOnly() {
    final DateTime date =
        DateTime.parse(this).toUtc().add(const Duration(hours: 7));
    final String month = _getMonthName(date.month);
    return '${date.day} $month ${date.year}';
  }

  String toFormattedDateOnlyWithStrip() {
    final DateTime date =
        DateTime.parse(this).toUtc().add(const Duration(hours: 7));
    return '${date.day} - ${date.month} - ${date.year}';
  }

  String toFormattedDateOnlyWithSlash() {
    final DateTime date =
        DateTime.parse(this).toUtc().add(const Duration(hours: 7));
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }

  String toFormatDateHistory() {
    if (isEmpty) {
      return '';
    }
    try {
      final DateTime dateTime = DateTime.parse(this);
      final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String toFormattedDateWithStrip() {
    try {
      final DateTime date =
          DateTime.parse(this).toUtc().add(const Duration(hours: 7));
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      return formatter.format(date);
    } catch (e) {
      return '';
    }
  }

  String toFormattedDateTimeWithStrip() {
    try {
      final DateTime dateTime =
          DateTime.parse(this).toUtc().add(const Duration(hours: 7));
      final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return '';
    }
  }
}

extension StringParsing on String {
  int? toIntOrNull() {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }

  int toIntOrDefault() {
    return toIntOrNull() ?? 0;
  }
}

extension StringToBase64 on String {
  String toBase64() {
    final bytes = utf8.encode(this);
    return base64.encode(bytes);
  }

  String fromBase64() {
    final bytes = base64.decode(this);
    return utf8.decode(bytes);
  }

  String toReadableText() {
    return replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
}

extension MaskString on String {
  String maskAccountNumber({
    int maskedStart = 0,
    int maskedEnd = 4,
  }) {
    if (length <= maskedStart + maskedEnd) {
      return this; 
    }

    substring(maskedStart, length - maskedEnd);
    final String maskedPart = '*' * (length - maskedStart - maskedEnd);
    return '${substring(0, maskedStart)}$maskedPart${substring(length - maskedEnd)}';
  }
}