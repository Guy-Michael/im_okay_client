import 'package:im_okay/Logger/i_logger.dart';

class Logger implements ILogger {
  @override
  void log(String message) {
    String dateTime = DateTime.now().toIso8601String().split(".")[0];
    print('im-okay: print: $dateTime - $message');
  }
}
