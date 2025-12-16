// config/environments/development_config.dart
// 🔴 Development Configuration - For daily coding
import 'package:baca_meter/config/app_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DevelopmentConfig extends AppConfig {
  @override
  String get appName => 'Mitra Mint Community (Dev)';

  @override
  String get baseApiUrl => dotenv.env['MINT_BASE_URL_SANDBOX']!;

  @override
  String get baseUrlNonGateway =>
      dotenv.env['MINT_BASE_URL_NON_GATEWAY_SANDBOX']!;

  @override
  String get customerServiceUrl =>
      dotenv.env['MINT_CUSTOMER_SERVICE_WEBSOCKET_URL_SANDBOX']!;

  @override
  String get environment => 'development';

  @override
  bool get isDebugMode => true; // 🐛 Debug logs enabled

  @override
  String get appSuffix => '.dev'; // 📱 Different bundle ID

  // 📊 Development Analytics (won't pollute prod data)
  @override
  String get analyticsKey => 'dev-analytics-key';

  @override
  String get crashlyticsKey => 'dev-crashlytics-key';

  // 🚀 All features enabled for testing
  @override
  bool get enableBetaFeatures => true;

  @override
  bool get showDebugInfo => true; // 📋 Show debug overlays
}
