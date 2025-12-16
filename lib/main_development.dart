import 'package:baca_meter/config/dev_config.dart';
import 'package:baca_meter/core/data/injection/injection.dart';
import 'package:baca_meter/main.dart';
import 'package:flutter/material.dart';
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

  // 🚀 Launch the app
  runApp(const MyApp());
}
