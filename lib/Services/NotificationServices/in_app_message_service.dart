import 'package:fluttertoast/fluttertoast.dart';

class InAppMessageService {
  static void showToast({required String message}) {
    Fluttertoast.showToast(msg: message);
  }
}
