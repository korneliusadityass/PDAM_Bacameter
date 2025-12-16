import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final bool filteringDigitsOnly;
  final int maxLength;

  CurrencyInputFormatter({
    this.filteringDigitsOnly = true,
    this.maxLength = 10,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    if (filteringDigitsOnly) {
      newText = newText.replaceAll(RegExp(r'[^\d]'), '');
    }

    if (newText.isEmpty) {
      return TextEditingValue.empty;
    }

    if (newText.length > maxLength) {
      newText = newText.substring(0, maxLength);
    }

    final double value = double.parse(newText);
    final formattedValue = value.toRupiah();
    final int newSelectionBase = formattedValue.length;
    final int newSelectionExtent = formattedValue.length;

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection(
        baseOffset: newSelectionBase,
        extentOffset: newSelectionExtent,
      ),
    );
  }
}

extension RupiahExtension on double {
  String toRupiah() {
    String rupiah = '';
    final String tempValue = toStringAsFixed(0);
    for (int i = 0; i < tempValue.length; i++) {
      if ((tempValue.length - i) % 3 == 0 && i != 0) {
        rupiah += '.';
      }
      rupiah += tempValue[i];
    }
    return 'Rp $rupiah';
  }
}