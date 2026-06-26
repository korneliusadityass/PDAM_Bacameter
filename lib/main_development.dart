import 'package:baca_meter/config/dev_config.dart';
import 'package:baca_meter/core/data/injection/injection.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Injection().init();
  await dotenv.load(fileName: '.env');
  await ScreenUtil.ensureScreenSize();

  // 🔧 Configure for development
  AppConfig.configure(DevelopmentConfig());

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primary500Base, // transparent status bar
      statusBarIconBrightness: Brightness.light, // light icons for Android
      statusBarBrightness: Brightness.dark, // light icons for iOS
    ),
  );

  // 🚀 Launch the app
  runApp(const MyApp());
}
