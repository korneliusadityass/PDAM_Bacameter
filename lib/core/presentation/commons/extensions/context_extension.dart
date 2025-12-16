import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  double get longestSide => MediaQuery.of(this).size.longestSide;

  double get shortestSide => MediaQuery.of(this).size.shortestSide;

  Orientation get orientation => MediaQuery.of(this).orientation;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  bool get isTablet => MediaQuery.of(this).size.shortestSide >= 550;

  bool get isPhone =>
      MediaQuery.of(this).size.shortestSide < 550 &&
      MediaQuery.of(this).size.shortestSide > 400;

  bool get isMpos {
    if (!Platform.isAndroid) {
      return false;
    }

    return (width >= 360 && width <= 480) && (height >= 550 && height <= 800);
  }

  bool get isDesktop => kIsWeb && MediaQuery.of(this).size.width > 800;

  double adaptiveFontSize(double baseFontSize) {
    if (isTablet) {
      return (baseFontSize + 1.0).sp;
    } else if (isPhone) {
      return baseFontSize.sp;
    } else {
      return baseFontSize.sp;
    }
  }

  void popMultipleTimes(int times) {
    for (int i = 0; i < times; i++) {
      pop();
    }
  }


}
