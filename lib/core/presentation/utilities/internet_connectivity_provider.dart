import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../manager/connectivity_manager.dart';

class InternetConnectionProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  late StreamSubscription _connectivitySubscription;

  InternetConnectionProvider() {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((_) async {
      final result = await ConnectivityManager.isOnline();

      if (_isConnected != result) {
        _isConnected = result;
        notifyListeners();
      }
    });

    ConnectivityManager.isOnline().then((result) {
      _isConnected = result;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
