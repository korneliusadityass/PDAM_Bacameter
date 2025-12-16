import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../commons/methods/methods.dart';
import '../commons/themes/color.dart';

class KeyboardUtils {
  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void copyToClipboard({
    required String text,
    required BuildContext context,
    Color? snackBarColor,
    Function()? onCopied,
  }) {
    Clipboard.setData(
      ClipboardData(text: text),
    ).then(
      (_) {
        if (context.mounted) {
          showCustomSnackBar(
            context,
            'Berhasil disalin ke papan klip',
            snackBarColor ?? primary700,
          );

          onCopied?.call();
        }
      },
    );
  }
}
