import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commons/themes/color.dart';

class CustomKeyboardButton extends StatelessWidget {
  final String? label;
  final ValueChanged<String>? onTap;

  // icon config (dipakai jika label == null)
  final IconData? iconParam;
  final Color? warnaIcons;
  final double? sizeIcon;

  // custom style
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  const CustomKeyboardButton({
    super.key,
    this.label,
    this.onTap,
    this.iconParam,
    this.warnaIcons,
    this.sizeIcon,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
  });

  bool get _isIconButton => iconParam != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap != null ? onTap!(label ?? '') : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: ShapeDecoration(
          color: backgroundColor ?? Colors.white,
          shadows: _isIconButton
              ? const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ]
              : null,
          shape: RoundedRectangleBorder(
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(width: 1, color: borderColor!),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    // 👉 Jika label ada → Text
    if (label != null) {
      return Text(
        label!,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor ?? text700,
          fontSize: 14.sp,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      );
    }

    // 👉 Jika label null → Icon
    return Center(
      child: Icon(iconParam, color: warnaIcons, size: sizeIcon ?? 20),
    );
  }
}
