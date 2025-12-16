import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class EncryptHelper {
  static final key256Auth =
      encrypt.Key.fromUtf8(dotenv.env['ENCRYPT_KEY_256_AUTH']!);
  static final key256Biller =
      encrypt.Key.fromUtf8(dotenv.env['ENCRYPT_KEY_256_BILLER']!);
  static final ivAuth = encrypt.IV.fromUtf8(dotenv.env['ENCRYPT_KEY_IV_AUTH']!);
  static final ivBiller =
      encrypt.IV.fromUtf8(dotenv.env['ENCRYPT_KEY_IV_BILLER']!);
  static final encrypterAuth = encrypt.Encrypter(
    encrypt.AES(key256Auth, mode: encrypt.AESMode.cbc),
  );
  static final encrypterBiller = encrypt.Encrypter(
    encrypt.AES(key256Biller, mode: encrypt.AESMode.cbc),
  );

  static String encryptAES256Auth(String plainText) {
    final encrypted = encrypterAuth.encrypt(plainText, iv: ivAuth);
    return encrypted.base64;
  }

  static String encryptAES256Biller(String plainText) {
    final encrypted = encrypterBiller.encrypt(plainText, iv: ivBiller);
    return encrypted.base64;
  }

  static String decryptAES256Auth(String encryptedText) {
    final decrypted = encrypterAuth.decrypt(
      encrypt.Encrypted.fromBase64(encryptedText),
      iv: ivAuth,
    );
    return decrypted;
  }

  static String decryptAES256Biller(String encryptedText) {
    final decrypted = encrypterBiller.decrypt(
      encrypt.Encrypted.fromBase64(encryptedText),
      iv: ivBiller,
    );
    return decrypted;
  }

  // static Future<void> generateEncryptDeviceInfo({
  //   String tokenSocialPlatform = '',
  // }) async {
  //   final deviceInfo = await DeviceHelper.generateNewDeviceInfo(
  //     tokenSocialPlatform: tokenSocialPlatform,
  //   );
  //   const jsonBuilder = JsonEncoder.withIndent('  ');
  //   final plainText = jsonBuilder.convert(deviceInfo.toJson());
  //   await SharedPrefsHelper.setDeviceInfo(encryptAES256Auth(plainText));
  // }

  static String generateSHA512BillerInquiry(
    String input,
    String secretKey,
  ) {
    final key = utf8.encode(secretKey);
    final bytes = utf8.encode(input);
    final hMacSha512 = crypto.Hmac(crypto.sha512, key);
    final digest = hMacSha512.convert(bytes);
    return base64.encode(digest.bytes);
  }

  static String generateSHA256FromJson(Map<String, dynamic> json) {
    final digest = crypto.sha256.convert(utf8.encode(jsonEncode(json)));
    final result = digest.toString();
    return result.toLowerCase();
  }
}