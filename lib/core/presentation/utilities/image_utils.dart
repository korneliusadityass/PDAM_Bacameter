import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  static Future<String> compressAndConvertImageToBase64(XFile file) async {
    try {
      final filePath = file.path;
      final targetPath = '${filePath}_compressed.jpg';

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        filePath,
        targetPath,
        quality: 70,
      );

      if (compressedFile == null) {
        throw Exception('Failed to compress image');
      }

      final bytes = await compressedFile.readAsBytes();
      final base64Str = base64Encode(bytes);

      return 'data:image/jpeg;base64,$base64Str';
    } catch (e) {
      debugPrint('Error saat compress image: $e');
      rethrow;
    }
  }
}