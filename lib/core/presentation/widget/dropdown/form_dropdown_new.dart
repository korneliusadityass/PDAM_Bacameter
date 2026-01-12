import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commons/themes/color.dart';
import '../../commons/themes/text_styel.dart';

class DropdownManual extends StatefulWidget {
  final String? selectedValue;
  final List<Map<String, String>> data;
  final String textHint;
  final Function(String? value)? onChanged;

  const DropdownManual({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.data,
    required this.textHint,
  });

  @override
  State<DropdownManual> createState() => _DropdownManualState();
}

class _DropdownManualState extends State<DropdownManual> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary500Base, width: 1),
      ),
      child: DropdownButton<String>(
        value: widget.selectedValue,
        items: widget.data.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem(
            value: item['isiList'], // Get the value from the map
            child: Text(
              item['isiList'].toString(),
              style: TextStyle(
                fontSize: 12.sp,
                color: neutralColor9,
                fontWeight: semiBold,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.onChanged?.call(value);
          });
        },
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        // Dropdown icon
        isExpanded: true,
        hint: Text(
          widget.textHint,
          style: TextStyle(
            // Add hintStyle here
            fontSize: 12.sp, // Customize font size
            color: Colors.grey.withValues(alpha: 0.5), // Customize color
            fontWeight: regular,
          ),
        ),
      ),
    );
  }
}
