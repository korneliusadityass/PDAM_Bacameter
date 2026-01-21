import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;

  const LoadingWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        width: size ?? 250.w,
        height: size ?? 250.w,
        'assets/lotties/anim_loading.json',
        repeat: true,
      ),
    );
  }
}
