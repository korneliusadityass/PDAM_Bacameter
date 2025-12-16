import 'package:baca_meter/core/presentation/commons/themes/text_styel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../widget/snack_bar/overlay_snackbar.dart';
import '../extensions/context_extension.dart';
import '../extensions/string_extension.dart';
import '../themes/color.dart';
import '../themes/constants.dart';

Map<double, SizedBox> _verticalSpaces = {};
Map<double, SizedBox> _horizontalSpaces = {};

SizedBox verticalSpace(double height) {
  if (!_verticalSpaces.containsKey(height)) {
    _verticalSpaces[height] = SizedBox(height: height);
  }

  return _verticalSpaces[height]!;
}

SizedBox horizontalSpace(double width) {
  if (!_horizontalSpaces.containsKey(width)) {
    _horizontalSpaces[width] = SizedBox(width: width);
  }

  return _horizontalSpaces[width]!;
}

Duration _snackBarDuration = const Duration(seconds: 2);
bool _canShowSnackBar = true;

void showCustomSnackBar(
  BuildContext context,
  String message,
  Color backgroundColor, [
  Color textColor = Colors.white,
]) {
  if (!_canShowSnackBar) return;
  _canShowSnackBar = false;

  final overlay = Overlay.of(context, rootOverlay: true);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return OverlaySnackBar(
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
        onDismissed: () => overlayEntry.remove(),
      );
    },
  );

  overlay.insert(overlayEntry);
  Future.delayed(_snackBarDuration, () {
    _canShowSnackBar = true;
  });
}

void showLoadingDialog(
  BuildContext context, {
  String message = 'Loading',
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Loading',
    pageBuilder: (context, animation, secondaryAnimation) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
            ),
            child: AlertDialog(
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              backgroundColor: neutralColor1,
              content: SizedBox(
                width: 60.w,
                height: 80.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: primary500Base),
                    verticalSpace(14.h),
                    Text(
                      '$message...',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 13.sp,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}

void hideLoadingDialog(BuildContext context) {
  if (context.mounted) {
    if (context.canPop()) {
      context.pop();
    }
  }
}


void showErrorDialogWithSingleAction(
  BuildContext context, {
  double? width,
  double? height,
  BoxFit? fit,
  required String title,
  String description = '',
  String illustration = 'error1',
  String positiveButton = 'OK',
  Color backgroundColor = const Color(0xFFB72F37),
  Function()? onPositivePressed,
  bool canDismiss = true,
  bool isTitleCase = true,
}) {
  showDialog(
    context: context,
    barrierDismissible: canDismiss,
    builder: (BuildContext dialogContext) {
      return PopScope(
        canPop: canDismiss, // 🔒 Blokir tombol back jika canDismiss = fals
        child: AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 17.w, vertical: 15.h),
          surfaceTintColor: neutralColor1,
          backgroundColor: neutralColor1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          content: SizedBox(
            width: (context.width * 0.8).w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/img_illustration_$illustration.webp',
                  width: width?.w ?? 170.w,
                  height: height?.w ?? 170.w,
                  fit: fit ?? BoxFit.contain,
                ),
                verticalSpace(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isTitleCase ? title.toTitleCase() : title,
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 13.sp,
                        ),
                      ),
                      if (description.isNotEmpty) ...[
                        verticalSpace(4.h),
                        Text(
                          description,
                          textAlign: TextAlign.center,
                          style: blackTextStyle.copyWith(
                            fontWeight: regular,
                            fontSize: 12.sp,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                verticalSpace(18.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onPositivePressed != null) {
                        onPositivePressed();
                      } else {
                        context.pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      positiveButton,
                      style: whiteTextStyle.copyWith(
                        fontWeight: bold,
                        fontSize: 13.sp,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

