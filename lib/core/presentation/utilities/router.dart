import 'package:baca_meter/core/presentation/page/home/feature/scan/scan_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';
import '../commons/routes/routes.dart';
import '../page/home/feature/daftar_rayon/daftar_rayon_page.dart';
import '../page/home/feature/daftar_rayon/list_pelanggan/list_pelanggan_page.dart';
import '../page/home/feature/detail_pelanggan/detail_pelanggan_page.dart';
import '../page/home/feature/last_digit/last_digit_page.dart';
import '../page/login/login_page.dart';
import '../page/main_page/main_page.dart';


class AppRouter {
  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    observers: [
      // ChuckerFlutter.navigatorObserver,
    ],
    routes: [
      // /// Splash
      // GoRoute(
      //   path: '/splash',
      //   name: Routes.splash,
      //   builder: (context, state) => const SplashPage(),
      // ),

      /// Authentication
      GoRoute(
        path: '/login-page',
        name: Routes.loginPage,
        builder: (context, state) => const LoginPage(),
      ),
      // Home
      GoRoute(
        path: '/main-page',
        name: Routes.mainPage,
        builder: (context, state) => const MainPage(),
      ),

      // DaftarRayonPage --> Wilayah
      GoRoute(
        path: '/daftar-rayon-page',
        name: Routes.daftarRayonPage,
        builder: (context, state) => const DaftarRayonPage(),
      ),

      // ListPelangganPage -->
      GoRoute(
        path: '/list-pelanggan-page',
        name: Routes.listPelangganPage,
        builder: (context, state) {
          final rayonId = state.uri.queryParameters['rayonId'] ?? '';
          final rayonName = state.uri.queryParameters['rayonName'] ?? '';

          return ListPelangganPage(rayonId: rayonId, rayonName: rayonName);
        },
      ),

      // LastDigitPage -->
      GoRoute(
        path: '/last-digit-page',
        name: Routes.lastDigitPage,
        builder: (context, state) => const LastDigitPage(),
      ),

      // ScanPage
      GoRoute(
        path: '/scan-page',
        name: Routes.scanPage,
        builder: (context, state) => const ScanPage(),
      ),

      // DetailPelangganPage
      GoRoute(
        path: '/detail-pelanggan-page',
        name: Routes.detailPelangganPage,
        builder: (context, state) => const DetailPelangganPage(),
      ),
    ],
    initialLocation: '/login-page',
    debugLogDiagnostics: kDebugMode ? true : false,
  );
}
