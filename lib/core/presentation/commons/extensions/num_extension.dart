extension CurrencyFormat on num {
  String toCurrencyWithRp() {
    return 'Rp${_formatCurrency()}';
  }

  String toCurrencyNoRp() {
    return _formatCurrency();
  }

  String toFormatWithRp() {
    return 'Rp${_formatCurrency()}';
  }

  String toFormatNoRp() {
    return _formatCurrency();
  }

  String _formatCurrency() {
    final bool hasDecimal = this is double && this % 1 != 0;

    final parts = hasDecimal ? toStringAsFixed(2).split('.') : [toInt().toString()];

    final reversed = parts[0].split('').reversed.toList();
    for (var i = 3; i < reversed.length; i += 4) {
      reversed.insert(i, '.');
    }

    return hasDecimal ? '${reversed.reversed.join('')},${parts[1]}' : reversed.reversed.join('');
  }
}
