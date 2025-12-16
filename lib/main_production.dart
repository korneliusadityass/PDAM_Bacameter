
import 'package:baca_meter/config/app_config.dart';
import 'package:baca_meter/config/prod_config.dart';
import 'package:baca_meter/core/data/injection/injection.dart';
import 'package:baca_meter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Injection().init();
  await dotenv.load(fileName: '.env');
  await ScreenUtil.ensureScreenSize();

  // 🔧 Configure for development
  AppConfig.configure(ProductionConfig());

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // 🚀 Launch the app
  runApp(const MyApp());
}
