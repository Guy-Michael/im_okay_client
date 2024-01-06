import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpUtils {
  static const String _localDomain = "http://10.0.2.2";
  static const String _localPort = "5129";
  static const String _serverDomain = "http://20.217.26.29";
  static const String _serverPort = "80";
  static const bool _isProduction = kReleaseMode;
  // static const bool _isProduction = true;
  // static const bool _isProduction = false;
  static Uri composeUri({required String endpoint}) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    String port = _isProduction ? _serverPort : _localPort;
    String url = "$domain:$port/$endpoint";
    Uri uri = Uri.parse(url);
    return uri;
  }

  static Map<String, String> _getHeaders() {
    var headers = {HttpHeaders.contentTypeHeader: 'Application/json'};

    return headers;
  }

  static String formatJsonBody(Map<String, Object> bodyMap) {
    String body = json.encode(bodyMap);
    return body;
  }

  static Future<String> post({required String endpoint, required Map<String, Object> body}) async {
    String bodyString = formatJsonBody(body);
    var headers = _getHeaders();

    Uri uri = composeUri(endpoint: endpoint);

    http.Response response = await http.post(uri, body: bodyString, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Request failed with status ${response.statusCode}');
    }

    return response.body;
  }
}
