import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../../commons/themes/color.dart';
import '../../commons/themes/text_styel.dart';
import '../../utilities/internet_connectivity_provider.dart';

class GlobalConnectionObserver extends StatefulWidget {
  final Widget child;

  const GlobalConnectionObserver({
    super.key,
    required this.child,
  });

  @override
  State<GlobalConnectionObserver> createState() =>
      _GlobalConnectionObserverState();
}

class _GlobalConnectionObserverState extends State<GlobalConnectionObserver> {
  bool? _prevConnected;

  void _showSnackBar(bool isConnected) {
    final message =
        isConnected ? 'Koneksi internet tersedia' : 'Koneksi internet terputus';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      toastification.showCustom(
        builder: (context, _) => Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 16.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isConnected ? primary600 : error600,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message,
            style: blackTextStyle.copyWith(
              fontSize: 14.sp,
              fontFamily: 'Inter',
              color: baseWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        autoCloseDuration: const Duration(milliseconds: 2000),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetConnectionProvider>(
      builder: (context, connectionProvider, child) {
        final currentConnected = connectionProvider.isConnected;

        if (_prevConnected != null && _prevConnected != currentConnected) {
          _showSnackBar(currentConnected);
        }

        _prevConnected = currentConnected;

        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => widget.child,
            ),
          ],
        );
      },
    );
  }
}
