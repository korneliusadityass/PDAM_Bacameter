// config/environments/production_config.dart
// 🟢 Production Configuration - For real users
import 'package:baca_meter/config/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProductionConfig extends AppConfig {
  @override
  String get appName => 'Mitra Mint Community';

  @override
  String get baseApiUrl => dotenv.env['MINT_BASE_URL_PRODUCTION']!;

  @override
  String get baseUrlNonGateway =>
      dotenv.env['MINT_BASE_URL_NON_GATEWAY_PRODUCTION']!;

  @override
  String get customerServiceUrl =>
      dotenv.env['MINT_CUSTOMER_SERVICE_WEBSOCKET_URL_PRODUCTION']!;

  @override
  String get environment => 'production';

  @override
  bool get isDebugMode => false; // 🔒 No debug info

  @override
  String get appSuffix => ''; // 📱 Clean bundle ID

  // 📊 Production Analytics
  @override
  String get analyticsKey => const String.fromEnvironment(
        'PROD_ANALYTICS_KEY',
        defaultValue: '',
      );

  @override
  String get crashlyticsKey => const String.fromEnvironment(
        'PROD_CRASHLYTICS_KEY',
        defaultValue: '',
      );

  // 🚀 Feature flags controlled remotely
  @override
  bool get enableBetaFeatures => false;

  @override
  bool get showDebugInfo => false; // 🔒 Never show debug info
}
