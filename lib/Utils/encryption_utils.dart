import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptionUtils {
  static String encryptOneWay(String value) {
    var p1 = utf8.encode(value);
    return sha256.convert(p1).toString();
  }

  static String encryptBase64(String value) {
    var p1 = utf8.encode(value);
    return base64Encode(p1);
  }

  static String decryptBase64(String value) {
    var base64Decoded = base64Decode(value);
    return utf8.decode(base64Decoded);
  }
}
