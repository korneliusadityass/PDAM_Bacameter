// config/app_config.dart
// 🎯 This abstract class defines the contract for all environments
abstract class AppConfig {
  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  // 📱 App Identity
  String get appName;

  String get baseApiUrl;
  String get customerServiceUrl;
  String get baseUrlNonGateway;

  String get environment;
  bool get isDebugMode;
  String get appSuffix;

  // 📊 Analytics & Monitoring
  String get analyticsKey;
  String get crashlyticsKey;

  // 🚀 Feature Flags
  bool get enableBetaFeatures;
  bool get showDebugInfo;

  // 🔧 Configuration Method
  static void configure(AppConfig config) {
    _instance = config;
  }
}
