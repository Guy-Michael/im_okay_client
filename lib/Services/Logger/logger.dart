import 'package:flutter/foundation.dart';

class Logger {
  static void log(String message) {
    String dateTime = DateTime.now().toIso8601String().split(".")[0];
    debugPrint('$dateTime im-okay: $message');
    // logger.i('im-okay: $message');
  }
}
