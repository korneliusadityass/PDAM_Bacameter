import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Widget? child;

  const ShimmerWidget({
    super.key,
    this.width = 50,
    this.height = 15,
    this.borderRadius = BorderRadius.zero,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: neutralColor3,
      highlightColor: neutralColor2,
      child: child ??
          Container(
            width: width.w,
            height: height.h,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: neutralColor1,
            ),
          ),
    );
  }
}
