import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityManager {
  static Future<bool> isOnline() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    }

    return false;
  }
}
