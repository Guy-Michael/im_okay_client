import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptionUtils {
  static String encrypt(String value) {
    var p1 = utf8.encode(value);
    return sha256.convert(p1).toString();
  }
}
