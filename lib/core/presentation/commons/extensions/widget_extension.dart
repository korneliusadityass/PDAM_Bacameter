import 'package:flutter/material.dart';

extension WidgetKeyExtension on Widget {
  // data real time web socket
  Widget withKey(Key key) {
    return KeyedSubtree(
      key: key,
      child: this,
    );
  }
}
