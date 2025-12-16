import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

extension XFileExtension on XFile {
  Future<String> toBase64() async {
    final bytes = await readAsBytes();
    final String base64Str = base64Encode(bytes);

    // Get the file extension
    final String ext = path.extension(this.path).split('.').last;

    // Combine the MIME type and base64 string
    return 'data:image/$ext;base64,$base64Str';
  }
}