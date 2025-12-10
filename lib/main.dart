import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/page/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dynamicSize =
        // context.isTablet ? const Size(900, 1280) :
        const Size(375, 812);

    ScreenUtil.init(context, designSize: dynamicSize);
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary500Base,
          surface: primary500Base,
          surfaceTint: text500Base,
          onSurface: text500Base,
        ),
      ),
      home: const LoginPage(),
    );
  }
}
