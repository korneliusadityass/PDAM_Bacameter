import 'dart:async';
import 'dart:io';

import 'package:baca_meter/core/presentation/commons/themes/color.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mutex/mutex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config/app_config.dart';
import '../../data/injection/injection.dart';
import '../commons/methods/methods.dart';

class DeviceHelper {
  static const deviceInfoChannel = MethodChannel('sdk.device.channel/info');
  static bool? _cachedIsMpos;
  static PackageInfo? _cachedPackageInfo;

  // App version utils
  static String _appVersion = '';
  static String _packageName = '';

  // Sync utils
  static final Mutex _mutex = Mutex();
  static LocationPermission? _lastPermissionStatus;

  static Future<void> init(BuildContext context) async {
    _cachedPackageInfo ??= await PackageInfo.fromPlatform();
    _appVersion =
        '${_cachedPackageInfo!.version}.${_cachedPackageInfo!.buildNumber}';
    _packageName = _cachedPackageInfo!.packageName;

    if (context.mounted) {
      _initializeMposCheck(context);
    }
  }

  static bool getIsDebugModeFromUrl() {
    const debugUrl = 'sandbox';

    if (AppConfig.instance.baseApiUrl.contains(debugUrl)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> getAllDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo;
    }
  }

  static Future<dynamic> getDeviceBrand() async {
    final DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.brand;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
  }

// Fungsi lain yang memanggil getDeviceBrandMpos dan mengembalikan hasilnya
  static Future<String> getDeviceBrandMpos() async {
    final brand = await getDeviceBrand();
    return brand.toString(); // Pastikan ini String
  }

  static Future<dynamic> _getDeviceIdNative() async {
    if (await setPermissionPhone()) {
      try {
        final result = await deviceInfoChannel
            .invokeMethod<String>('getSerialAndroidID', <String, dynamic>{});
        return result ?? '';
      } on PlatformException catch (e) {
        return e.message;
      }
    }
  }

  static Future<bool> setPermissionPhone() async {
    final isPermissionGranted = await Permission.phone
        .onGrantedCallback(() => true)
        .onDeniedCallback(() => false)
        .request()
        .isGranted;

    if (isPermissionGranted) {
      return true;
    }
    return false;
  }

  static Future<dynamic> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();
    if (Platform.isAndroid) {
      if (!isMpos) {
        return _getDeviceIdNative();
      } else {
        return _getMposSerialNumber();
      }
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
  }

  static Future<dynamic> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    }
  }

  static Future<dynamic> getDeviceType() async {
    final DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.type;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
  }

  static String getAppVersion() => _appVersion;

  static String getPackageName() => _packageName;

  // static Future<Position> getCurrentLocation() async {
  //   final deviceBrand = await getDeviceBrandMpos();
  //   debugPrint('device: $deviceBrand');
  //   debugPrint('isMpos: $isMpos');
  //   if (isMpos && (deviceBrand.toLowerCase() == 'aisino')) {
  //     final result = await getAisinoLocation();

  //     if (result.isEmpty) {
  //       debugPrint('getAisinoLocation: empty result');
  //       final cacheUserLocation = SharedPrefsHelper.getUserLastLocation();
  //       if (cacheUserLocation != null) {
  //         return cacheUserLocation;
  //       } else {
  //         return setDefaultPosition();
  //       }
  //     }

  //     final parts = result.split('|');
  //     if (parts.length != 2) {
  //       debugPrint('getAisinoLocation: invalid format "$result"');
  //       final cacheUserLocation = SharedPrefsHelper.getUserLastLocation();
  //       if (cacheUserLocation != null) {
  //         return cacheUserLocation;
  //       } else {
  //         return setDefaultPosition();
  //       }
  //     }

  //     final lat = double.tryParse(parts[0]) ?? 0.0;
  //     final lon = double.tryParse(parts[1]) ?? 0.0;

  //     final position = Position(
  //       latitude: lat,
  //       longitude: lon,
  //       timestamp: DateTime.now(),
  //       accuracy: 0.0,
  //       altitude: 0.0,
  //       heading: 0.0,
  //       speed: 0.0,
  //       speedAccuracy: 0.0,
  //       altitudeAccuracy: 0.0, // ✅ tambahkan
  //       headingAccuracy: 0.0, // ✅ tambahkan
  //     );

  //     await SharedPrefsHelper.setUserLastLocation(position);
  //     return position;
  //   } else {
  //     debugPrint('getAisinoLocation: not mpos');
  //     return _mutex.protect(() async {
  //       bool serviceEnabled;
  //       LocationPermission permission;

  //       serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //       if (!serviceEnabled) {
  //         final cacheUserLocation = SharedPrefsHelper.getUserLastLocation();
  //         if (cacheUserLocation != null) {
  //           return cacheUserLocation;
  //         } else {
  //           debugPrint('Location services are disabled.');
  //           return setDefaultPosition();
  //         }
  //       }

  //       permission = await Geolocator.checkPermission();
  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //         if (permission == LocationPermission.denied) {
  //           debugPrint('Location permissions are denied');
  //           return setDefaultPosition();
  //         }
  //       }

  //       if (permission == LocationPermission.deniedForever) {
  //         debugPrint(
  //             'Location permissions are permanently denied, we cannot request permissions.');
  //         return setDefaultPosition();
  //       }

  //       final currentPosition = await Geolocator.getCurrentPosition();
  //       await SharedPrefsHelper.setUserLastLocation(currentPosition);
  //       return currentPosition;
  //     });
  //   }
  // }

  static Future<bool> requestLocationPermission() async {
    if (_lastPermissionStatus == LocationPermission.whileInUse ||
        _lastPermissionStatus == LocationPermission.always) {
      return true;
    }

    _lastPermissionStatus = await Geolocator.checkPermission();
    if (_lastPermissionStatus == LocationPermission.denied) {
      _lastPermissionStatus = await Geolocator.requestPermission();
    }

    if (_lastPermissionStatus == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    return _lastPermissionStatus != LocationPermission.denied;
  }

  static Position setDefaultPosition() {
    return Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  // static Future<DeviceInfo> generateNewDeviceInfo({
  //   String tokenSocialPlatform = '',
  // }) async {
  //   final position = await DeviceHelper.getCurrentLocation();
  //     final deviceBrand = await getDeviceBrandMpos();
  //   String? fcmToken;
  //   if (isMpos && (deviceBrand.toLowerCase() == 'aisino')) {
  //     fcmToken = ''; // MPOS Aisino tidak pakai FCM
  //   } else {
  //     fcmToken = await sl<FirebaseMessaging>().getToken();
  //   }


  //   return DeviceInfo(
  //     dateTime: DateTime.now().toString(),
  //     deviceBrand: await getDeviceBrand(),
  //     deviceId: await getDeviceId(),
  //     deviceModel: await getDeviceModel(),
  //     deviceType: DeviceHelper.isMpos ? 'mpos' : 'mobile',
  //     latitude: '${position.latitude}',
  //     longitude: '${position.longitude}',
  //     appVersion: getAppVersion(),
  //     packageName: getPackageName(),
  //     fcmToken: fcmToken,
  //     tokenSocialPlatform: tokenSocialPlatform,
  //   );

    
  // }

  // static Future<String> getFcmToken() async {
  //   return await sl<FirebaseMessaging>().getToken() ?? '';
  // }

  static Future<bool> _isMPOSBrand() async {
    final String deviceBrand = await DeviceHelper.getDeviceBrand();
    final List<String> mPOSBrand = [
      'sunmi',
      'pax',
      'verifone',
      'ingenico',
      'doro',
      'aisino',
    ];
    return mPOSBrand.contains(deviceBrand.toLowerCase());
  }

  static Future<void> _initializeMposCheck(BuildContext context) async {
    if (Platform.isAndroid) {
      final bool isMposBrand = await _isMPOSBrand();

      if (isMposBrand) {
        if (context.mounted) {
          final size = MediaQuery.of(context).size;
          final width = size.width;
          final height = size.height;

          _cachedIsMpos = (width >= 360 && width <= 480) &&
              (height >= 550 && height <= 800);
        }
      } else {
        _cachedIsMpos = false;
      }
    } else {
      _cachedIsMpos = false;
    }
  }

  static bool get isMpos {
    return _cachedIsMpos ?? false;
  }

  static double setIosSize(double iosSize, double androidSize) {
    if (Platform.isIOS) {
      return iosSize;
    } else {
      return androidSize;
    }
  }

  static void checkFeatureOnAndroidOnly({
    required BuildContext context,
    required Function()? onFeatureAvailable,
  }) {
    if (Platform.isAndroid) {
      onFeatureAvailable?.call();
    } else {
      showCustomSnackBar(
        context,
        'Fitur hanya tersedia di platform Android',
        error500,
      );
    }
  }

  static Future<dynamic> _getMposSerialNumber() async {
    if (await setPermissionPhone()) {
      try {
        final result = await deviceInfoChannel
            .invokeMethod<String>('getSerialNumber', <String, dynamic>{});

        debugPrint('getSerialNumber: $result');

        return result ?? '';
      } on PlatformException catch (e) {
        return e.message;
      }
    }
  }

  static Future<String> getAisinoLocation() async {
    try {
      final result = await deviceInfoChannel.invokeMethod<String>(
          'getAisinoLocation', <String, dynamic>{}).timeout(
        const Duration(seconds: 5), // 5-second timeout to prevent hanging
        onTimeout: () {
          debugPrint('getAisinoLocation: Timed out after 5 seconds');
          return ''; // Return empty on timeout to trigger default
        },
      );

      debugPrint('getAisinoLocation: $result');

      return result ?? '';
    } on PlatformException catch (e) {
      debugPrint('getAisinoLocation: ${e.message}');
      return '';
    } on TimeoutException catch (e) {
      debugPrint('getAisinoLocation: Timeout exception - ${e.message}');
      return '';
    }
  }
}
