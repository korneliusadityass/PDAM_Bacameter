import 'dart:async';

import 'package:baca_meter/core/presentation/commons/language/language.dart';
import 'package:baca_meter/core/presentation/commons/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../commons/extensions/context_extension.dart';
import '../../commons/routes/routes.dart';
import '../../commons/themes/color.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isPhone) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    // final splashNotifier = sl<SplashNotifier>();
    // splashNotifier
    //   ..checkFirstLaunch()
    //   ..checkExpiredToken();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 4), () {
        if (!context.mounted) return;

        // if (splashNotifier.isSignedIn) {
        //   context.goNamed(Routes.main);
        // } else if (splashNotifier.isFirstLaunch) {
        //   context.goNamed(Routes.onboarding);
        // } else {
        context.goNamed(Routes.loginPage);
        // }
      });
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primary500Base,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              // 🔹 Background image + tint color
              Image.asset(
                'assets/images/bg_login.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              // 🔹 Logo di tengah
              Center(
                child: Image.asset(
                  'assets/icon/ic_baca_meter.png',
                  width: 134.w,
                  height: 120.h,
                ),
              ),

              // 🔹 Footer
              Positioned(
                left: 0,
                right: 0,
                bottom: 16.h,
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        Language.poweredBy,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      verticalSpace(8.h),
                      Image.asset(
                        'assets/icon/logo_mkp_white.png',
                        width: 85.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
