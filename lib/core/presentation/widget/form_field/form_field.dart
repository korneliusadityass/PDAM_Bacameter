import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commons/themes/text_styel.dart';
import '../../utilities/function_formater_keywoard_rupiah.dart';

class FormFieldWigets extends StatelessWidget {
  const FormFieldWigets({
    super.key,
    required TextEditingController textEditingController,
    required this.focusNode,
    required this.textHint,
    required this.jenisInputan,
  }) : _textKodeController = textEditingController;

  final TextEditingController _textKodeController;
  final FocusNode focusNode;
  final String textHint;
  final String jenisInputan;

  @override
  Widget build(BuildContext context) {
    final List<TextInputFormatter> inputFormatters = [];
    if (jenisInputan == 'harga') {
      // inputFormatters.add(CurrencyInputFormatter());
      inputFormatters.add(
        CurrencyInputFormatter(maxLength: 12),
      ); // Set desired max length
    } else if (jenisInputan.toLowerCase() == 'int') {
      // Enforce numeric input using FilteringTextInputFormatter
      inputFormatters.addAll([
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ]);
    } else if (jenisInputan == 'double') {
      inputFormatters.add(
        TextInputFormatter.withFunction((oldValue, newValue) {
          // Check if the new value is empty (backspace pressed)
          if (newValue.text.isEmpty) {
            return newValue;
          }

          // Check if the new value is a valid double
          final double? value = double.tryParse(newValue.text);
          if (value == null) {
            // If not a valid double, revert to the old value
            return oldValue;
          }

          // Ensure the decimal point can only be added after entering at least one digit
          if (newValue.text == '.') {
            return newValue;
          }

          // Ensure only two digits are allowed after the decimal point
          final splitValue = newValue.text.split('.');
          if (splitValue.length == 2 && splitValue[1].length > 2) {
            // If more than two digits after decimal, revert to the old value
            return oldValue;
          }

          // If all conditions pass, return the new value
          return newValue;
        }),
      );
      inputFormatters.add(
        LengthLimitingTextInputFormatter(12),
      ); // 12 character limit
      inputFormatters.add(LengthLimitingTextInputFormatter(10));
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white /* Color-Base-color-Background-Bg-white */,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: borderDefault),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            onChanged: (value) => {_textKodeController.text == value},
            controller: _textKodeController,
            focusNode: focusNode,
            onTapOutside: (event) => focusNode.unfocus(),
            keyboardType: jenisInputan == 'String'
                ? TextInputType.text
                : TextInputType.number,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // 🔹 penting
              contentPadding: EdgeInsets.zero, // 🔹 hilangkan padding bawaa
              border: InputBorder.none,
              hintText: textHint,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.withValues(alpha: 0.5),
                fontWeight: regular,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              color: neutralColor9,
              fontWeight: semiBold,
            ),
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
