import 'package:flutter/foundation.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:http/http.dart' as http;

class HttpUtils {
  static const String _localDomain = "http://localhost";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.28.18";
  static const String _serverPort = "5000";
  static const bool _isProduction = bool.fromEnvironment('dart.vm.product');

  static Uri composeUri(String endpoint) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/$endpoint";
    Uri uri = Uri.parse(url);
    return Uri.parse(url);
  }

  static Future<void> reportOkay() async {
    Uri uriLogin = HttpUtils.composeUri("api/login");
    String accessToken = User.generateAccessToken("guy", "12345");
    Map<String, String> headers = {'Authorization': accessToken};
    var response = await http.get(uriLogin, headers: headers);
    debugPrint(response.body);
  }
}
