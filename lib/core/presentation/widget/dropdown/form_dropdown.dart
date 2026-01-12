import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

class FormDropdownButton extends StatefulWidget {
  final String? selectedValue;
  final Function(String? value)? onChanged;
  final String textHint;
  final List<Map<String, String>> data;

  // final FocusNode? focusNode;
  // final TextEditingController controller;

  final VoidCallback? onTap; // 🔹 tambahan

  const FormDropdownButton({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.textHint,
    required this.data,

    // this.focusNode,
    // this.controller,
    this.onTap,
  });

  @override
  State<FormDropdownButton> createState() => _FormDropdownButtonState();
}

class _FormDropdownButtonState extends State<FormDropdownButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => widget.onTap?.call(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.w),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderDefault, width: 1),
            ),
            child: Row(
              children: [
                Icon(Remix.contrast_drop_2_fill, color: baseBlack, size: 20),
                horizontalSpace(16.w),
                Expanded(
                  child: Text(
                    widget.selectedValue ?? widget.textHint,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.selectedValue != null
                          ? text500Base
                          : text400,
                    ),
                  ),
                ),
                Icon(Remix.arrow_down_s_line, color: baseBlack, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
