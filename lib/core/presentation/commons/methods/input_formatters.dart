import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filteredText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (filteredText.isEmpty || filteredText.startsWith('8')) {
      return newValue.copyWith(
        text: filteredText,
        selection: TextSelection.collapsed(offset: filteredText.length),
      );
    }

    return oldValue;
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    final String newText = newValue.text;

    if (regExp.hasMatch(newText)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class NpwpInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 5 || i == 8) {
        buffer.write('.');
      } else if (i == 9) {
        buffer.write('-');
      } else if (i == 12) {
        buffer.write('.');
      }
      buffer.write(digitsOnly[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!RegExp(r'^\d{0,2}(-\d{0,2})?(-\d{0,4})?$').hasMatch(newValue.text)) {
      return oldValue;
    }

    var text = newValue.text;
    if (text.length == 2 || text.length == 5) {
      if (oldValue.text.length < text.length) {
        text += '-';
      } else {
        text = text.substring(0, text.length - 1);
      }
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class PriceInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || newValue.text == 'Rp') {
      return const TextEditingValue(
        text: 'Rp0',
        selection: TextSelection.collapsed(offset: 3),
      );
    }

    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.isEmpty) {
      newText = '0';
    }

    final formattedText = _currencyFormat.format(int.parse(newText));

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class PreventLeadingZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.startsWith('0') && newText.length > 1) {
      return oldValue;
    }

    return newValue;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: 'Rp0',
        selection: TextSelection.collapsed(offset: 'Rp0'.length),
      );
    }

    final int value =
        int.parse(newValue.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final formattedValue = _currencyFormat.format(value);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
