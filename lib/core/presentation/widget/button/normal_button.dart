import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commons/themes/color.dart';
import '../../commons/themes/text_styel.dart';

class NormalButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final bool isEnabled;
  final bool isLoading;
  final Function()? onPressed;
  final double? fontSize;
  final double verticalPadding;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? titleTextColor;
  final bool? withIconOnLeft;
  final Widget? iconOnLeft;
  final double? elevation;

  const NormalButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 45,
    this.isEnabled = true,
    this.isLoading = false,
    this.onPressed,
    this.fontSize,
    this.verticalPadding = 10,
    this.fontWeight,
    this.backgroundColor,
    this.titleTextColor,
    this.withIconOnLeft = false,
    this.iconOnLeft,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: neutralColor4,
          backgroundColor: backgroundColor ?? primary500Base,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: verticalPadding.h,
          ),
          elevation: elevation,
        ),
        child: isLoading
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(neutralColor1),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (withIconOnLeft == true && iconOnLeft != null)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: iconOnLeft,
                    ),
                  Text(
                    title,
                    style: whiteTextStyle.copyWith(
                      fontSize: fontSize ?? 14.sp,
                      fontWeight: fontWeight ?? semiBold,
                      color: titleTextColor ?? baseWhite,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
