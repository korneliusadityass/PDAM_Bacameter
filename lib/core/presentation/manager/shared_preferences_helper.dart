



class SharedPrefsHelper {
  // Key: Onboarding
  static const String isFirstLaunchKey = 'isFirstLaunch';
  static const String deviceInfoKey = 'deviceInfo';

  // Key: Authentication
  static const String userTokenKey = 'userToken';
  static const String isSignedInKey = 'isSignedIn';
  static const String isSignOtpKey = 'isSignOtp';
  static const String userLocalKey = 'userLocal';
  static const String username = 'username';
  static const String appleEmailKey = 'appleEmail';
  static const String appleUsernameKey = 'appleUsername';

  // Key: User
  static const String userAttributeKey = 'userAttribute';

  // Key: User Last Location
  static const String userLastLocationKey = 'userLastLocation';

  // Key: Showcase
  static const String showcaseHomePageTransferBinaKey =
      'showcaseHomeTransferBina';
  static const String showcaseHomePageMutasiBinaKey = 'showcaseHomeMutasiBina';
  static const String showcaseTransferPageBinaKey = 'showcaseTransferPageBina';

  // Key: Token LMS
  static const String tokenLMS = 'tokenLMS';

  // static Future<bool> isFirstLaunch() async {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getBool(isFirstLaunchKey) ?? true;
  // }

  // static Future setFirstLaunch(bool isFirstLaunch) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setBool(isFirstLaunchKey, isFirstLaunch);
  // }

  // static bool isSignedIn() {
  //   return getUserToken() != null && getIsSignInOtp() == true;
  // }

  // /// Don't remove user apple information
  // static Future logoutUser() async {
  //   final prefs = sl<SharedPreferences>();

  //   prefs.remove(userTokenKey);
  //   prefs.remove(isSignOtpKey);
  //   prefs.remove(userLocalKey);
  //   prefs.remove(username);
  //   prefs.remove(userAttributeKey);
  //   prefs.remove(tokenLMS);
  // }

  // static Future<String?> getDeviceInfo() async {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(deviceInfoKey);
  // }

  // static Future setDeviceInfo(String deviceInfo) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setString(deviceInfoKey, deviceInfo);
  // }

  // static String? getUserToken() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(userTokenKey);
  // }

  // static Future setUserToken(String userToken) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setString(userTokenKey, userToken);
  // }

  // static Future setIsSignInOtp(bool isSign) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setBool(isSignOtpKey, isSign);
  // }

  // static bool? getIsSignInOtp() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getBool(isSignOtpKey) ?? false;
  // }

  // static Future saveUserLogin(UserLocal user) async {
  //   final prefs = sl<SharedPreferences>();
  //   final userJson = jsonEncode(user.toJson());
  //   await prefs.setString(userLocalKey, userJson);
  // }

  // static UserLocal? getUserLocal() {
  //   final prefs = sl<SharedPreferences>();
  //   final String? userJson = prefs.getString(userLocalKey);
  //   if (userJson != null) {
  //     return UserLocal.fromJson(jsonDecode(userJson));
  //   } else {
  //     return null;
  //   }
  // }

  // static Future saveAppleInformation(
  //   String appleEmail,
  //   String appleUsername,
  // ) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setString(appleEmailKey, appleEmail);
  //   await prefs.setString(appleUsernameKey, appleUsername);
  // }

  // static String? getAppleEmail() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(appleEmailKey);
  // }

  // static String? getAppleUsername() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(appleUsernameKey);
  // }

  // static Future setUsername(String value) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setString(username, value);
  // }

  // static String getUsername() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(username) ?? '';
  // }

  // static Future setUserAttribute(AttributeResponse attr) async {
  //   final prefs = sl<SharedPreferences>();
  //   final attrJson = jsonEncode(attr.toJson());
  //   await prefs.setString(userAttributeKey, attrJson);
  // }

  // static AttributeResponse? getUserAttribute() {
  //   final prefs = sl<SharedPreferences>();
  //   final String? attrJson = prefs.getString(userAttributeKey);
  //   if (attrJson != null) {
  //     return AttributeResponse.fromJson(jsonDecode(attrJson));
  //   } else {
  //     return null;
  //   }
  // }

  // static Future setUserLastLocation(Position lastLocation) async {
  //   final prefs = sl<SharedPreferences>();
  //   final locationJson = jsonEncode(lastLocation.toJson());
  //   await prefs.setString(userLastLocationKey, locationJson);
  // }

  // static Position? getUserLastLocation() {
  //   final prefs = sl<SharedPreferences>();
  //   final String? locationJson = prefs.getString(userLastLocationKey);
  //   if (locationJson != null) {
  //     return Position.fromMap(jsonDecode(locationJson));
  //   } else {
  //     return null;
  //   }
  // }

  // // Showcase Attribute
  // static Future<bool> isShowcaseTransferHomePagePassed() async {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getBool(showcaseHomePageTransferBinaKey) ?? true;
  // }

  // static Future setShowcaseTransferHomePagePassed(bool value) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setBool(showcaseHomePageTransferBinaKey, value);
  // }

  // static Future<bool> isShowcaseMutasiBinaHomePagePassed() async {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getBool(showcaseHomePageMutasiBinaKey) ?? true;
  // }

  // static Future setShowcaseMutasiBinaHomePagePassed(bool value) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setBool(showcaseHomePageMutasiBinaKey, value);
  // }

  // static Future<bool> isShowcaseTransferPagePassed() async {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getBool(showcaseTransferPageBinaKey) ?? true;
  // }

  // static Future setShowcaseTransferPagePassed(bool value) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setBool(showcaseTransferPageBinaKey, value);
  // }

  // // LMS
  // static Future setTokenLMS(String value) async {
  //   final prefs = sl<SharedPreferences>();
  //   await prefs.setString(tokenLMS, value);
  // }

  // static String getTokenLMS() {
  //   final prefs = sl<SharedPreferences>();
  //   return prefs.getString(tokenLMS) ?? '';
  // }
}
