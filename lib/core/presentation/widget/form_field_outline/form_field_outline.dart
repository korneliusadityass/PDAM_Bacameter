import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class FormFieldOutline extends StatelessWidget {
  final TextInputType inputType;
  final TextEditingController controller;
  final String hint;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  // bintang2 for password
  final bool obscureText;
  final TextStyle? hintTextStyle;
  final TextStyle? valueTextStyle;
  final EdgeInsetsGeometry? contentPadding;

  final ValueNotifier<bool> _obscureTextNotifier;
  final FocusNode? focusNode;

  // Parameter baru untuk icon di sebelah kiri
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? prefixIconPadding;

  FormFieldOutline({
    super.key,
    required this.controller,
    required this.hint,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.inputFormatters,
    this.validator,
    this.obscureText = false,
    this.hintTextStyle,
    this.valueTextStyle,
    this.contentPadding,
    this.focusNode,
    this.prefixIcon,
    this.prefixIconPadding,
  }) : _obscureTextNotifier = ValueNotifier<bool>(obscureText);

  @override
  Widget build(BuildContext context) {
      return ValueListenableBuilder<bool>(
        valueListenable: _obscureTextNotifier,
        builder: (context, obscureNotifier, child) {
          return TextFormField(
            focusNode: focusNode,
            keyboardType: inputType,
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureNotifier,
            style:
                valueTextStyle ??
                TextStyle(
                  fontSize: 14.sp,
                  color: text500Base,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
            decoration: InputDecoration(
              contentPadding:
                  contentPadding ??
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
              hintText: hint,
              hintStyle:
                  hintTextStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    color: text400,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: borderDefault),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderLight),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: borderDefault),
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding:
                          prefixIconPadding ??
                          EdgeInsets.symmetric(horizontal: 12.w),
                      child: prefixIcon,
                    )
                  : null,
              suffixIcon: obscureText
                  ? IconButton(
                      icon: Icon(
                        obscureNotifier ? Remix.eye_line : Remix.eye_off_fill,
                        color: obscureNotifier ? primary500Base : Colors.black,
                      ),
                      onPressed: () {
                        _obscureTextNotifier.value = !obscureNotifier;
                      },
                    )
                  : null,
            ),
            inputFormatters: inputFormatters,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTapOutside: (_) => focusNode?.unfocus(),
            onFieldSubmitted: (_) => focusNode?.unfocus(),
          );
        },
      );
  }
}
