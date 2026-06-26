import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../manager/connectivity_manager.dart';

class InternetConnectionProvider with ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  bool _isDisposed = false;
  late StreamSubscription _connectivitySubscription;

  InternetConnectionProvider() {
    _initialize();
  }

  void _initialize() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((_) async {
      final result = await ConnectivityManager.isOnline();

      if (_isDisposed) return;
      
      if (_isConnected != result) {
        _isConnected = result;
        notifyListeners();
      }
    });

    ConnectivityManager.isOnline().then((result) {
      if (_isDisposed) return;
      
      if (_isConnected != result) {
        _isConnected = result;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
