import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
// import 'package:logging_to_logcat/logging_to_logcat.dart';

// import 'package:flutter/foundation.dart';
// import 'package:logger/logger.dart';
// import 'package:logging_to_logcat/logging_to_logcat.dart';

MyLogger logger = MyLogger();

// Logger
class MyLogger {
  late Logger _logger;

  MyLogger() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    _logger = Logger('im-okay');
    // Logger.root.activateLogcat();
    // Logger.root.onRecord.listen((record) {
    //   print('${record.level.name}: ${record.time}: ${record.message}');
    // });
  }

  void log(String message) {
    String dateTime = DateTime.now().toIso8601String().split(".")[0];
    // _logger.log(Level.ALL, '$dateTime: $message');
    // _logger.log(Level.ALL, 'im-okay: $dateTime - $message');
    print('im-okay: print: $dateTime - $message');
    // debugPrint('im-okay: print: $dateTime - $message');
    // debugPrint('$dateTime im-okay: $message');
    // logger.i('$dateTime im-okay: $message');
  }
}
