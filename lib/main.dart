import 'dart:io';

import 'package:baca_meter/config/app_config.dart';
import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:baca_meter/core/presentation/utilities/router.dart';
import 'package:baca_meter/core/presentation/widget/connection_widgets/global_connectivity_observer.dart';
import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:safe_device/safe_device.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:toastification/toastification.dart';

import 'core/presentation/manager/device_helper.dart';
import 'core/presentation/manager/multi_provider_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _firebaseMessageManager = sl<FirebaseMessageManager>();
  // final _deepLinkManager = sl<DeepLinkManager>();

  bool _isDevModeOn = false;

  @override
  void initState() {
    super.initState();
    // _firebaseMessageManager.init(context);
    // _deepLinkManager.init();
    DeviceHelper.init(context);
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    try {
      if (kReleaseMode && AppConfig.instance.environment == 'production') {
        final isDevMode = await SafeDevice.isDevelopmentModeEnable;
        if (isDevMode) {
          if (mounted) {
            setState(() {
              _isDevModeOn = true;
            });
          }
        }
      }
    } catch (e) {
      // Ignored if package fails on certain unsupported devices
    }
  }

  @override
  void dispose() {
    super.dispose();
    // _deepLinkManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDevModeOn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.security, size: 80, color: Colors.red),
                  const SizedBox(height: 24),
                  const Text(
                    'Keamanan Perangkat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Harap matikan Opsi Pengembang (Developer Options) pada perangkat Anda untuk menggunakan aplikasi ini. Ini adalah standar keamanan perusahaan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else {
                          exit(0);
                        }
                      },
                      child: const Text(
                        'Keluar Aplikasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final dynamicSize = MediaQuery.of(context).size;

    return MultiProvider(
      providers: MultiProviderHelper.allProviders(),
      child: ScreenUtilInit(
        designSize: dynamicSize,
        ensureScreenSize: true,
        enableScaleText: () => false,
        enableScaleWH: () => false,
        child: ToastificationWrapper(
          child: ShowCaseWidget(
            builder: (context) => Builder(
              builder: (context) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: 'PDAM Baca Meter',
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: primary500Base,
                        statusBarIconBrightness: Brightness.light,
                        statusBarBrightness: Brightness.dark,
                      ),
                    ),
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: primary500Base,
                      surface: primary500Base,
                      surfaceTint: text500Base,
                      onSurface: text500Base,
                    ),
                    useMaterial3: true,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    textTheme: GoogleFonts.interTextTheme(
                      Theme.of(context).textTheme,
                    ),
                    pageTransitionsTheme: const PageTransitionsTheme(
                      builders: {
                        TargetPlatform.android:
                            CupertinoPageTransitionsBuilder(),
                        TargetPlatform.iOS:
                            CupertinoWillPopScopePageTransionsBuilder(),
                      },
                    ),
                  ),
                  routerConfig: AppRouter.routes,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('id', 'ID'),
                  ],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  builder: (context, child) {
                    final mediaQuery = MediaQuery.of(context);
                    return MediaQuery(
                      data: MediaQueryData(
                        size: mediaQuery.size,
                        devicePixelRatio: mediaQuery.devicePixelRatio,
                        //ignore: deprecated_member_use
                        textScaleFactor: 0.9,
                        platformBrightness: mediaQuery.platformBrightness,
                        padding: mediaQuery.padding,
                        viewPadding: mediaQuery.viewPadding,
                        viewInsets: mediaQuery.viewInsets,
                        systemGestureInsets: mediaQuery.systemGestureInsets,
                        accessibleNavigation: mediaQuery.accessibleNavigation,
                        invertColors: mediaQuery.invertColors,
                        alwaysUse24HourFormat: mediaQuery.alwaysUse24HourFormat,
                        disableAnimations: mediaQuery.disableAnimations,
                        boldText: mediaQuery.boldText,
                        navigationMode: mediaQuery.navigationMode,
                      ),
                      child: GlobalConnectionObserver(child: child!),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
