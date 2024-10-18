import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';

class HttpUtils {
  static const String _localDomain = "10.0.2.2";
  // static const String _localDomain = "http://127.0.0.1";
  static const int _localPort = 5129;
  static const String _serverDomain = "http://20.51.219.132";
  static const int _serverPort = 80;
  static const bool _isProduction = kReleaseMode;
  static Uri composeUri({required String endpoint, Map<String, Object>? queryParams}) {
    String domain = _isProduction ? _serverDomain : _localDomain;
    int port = _isProduction ? _serverPort : _localPort;
    Uri uri = Uri.http("$domain:$port", endpoint, queryParams);
    return uri;
  }

  static Future<Map<String, String>> _getHeaders() async {
    String idToken = await UserAuthenticationApiService.getFirebaseAuthToken();
    var headers = {
      HttpHeaders.contentTypeHeader: 'Application/json',
      HttpHeaders.authorizationHeader: idToken
    };
    return headers;
  }

  static String formatJsonBody(Map<String, dynamic> bodyMap) {
    String body = json.encode(bodyMap);
    return body;
  }

  static Future<String> post({required String endpoint, required Map<String, dynamic> body}) async {
    String bodyString = formatJsonBody(body);
    var headers = await _getHeaders();

    Uri uri = composeUri(endpoint: endpoint);

    http.Response response = await http.post(uri, body: bodyString, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Request failed with status ${response.statusCode}');
    }

    return response.body;
  }

  static Future<String> get({required String endpoint, Map<String, Object>? queryParams}) async {
    var headers = await _getHeaders();
    Uri uri = composeUri(endpoint: endpoint, queryParams: queryParams);
    http.Response response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Get request failed with stats ${response.statusCode}');
    }

    return response.body;
  }

  static Future<bool> delete({required endpoint}) async {
    Map<String, String> headers = await _getHeaders();
    Uri uri = composeUri(endpoint: endpoint);
    http.Response response = await http.delete(uri, headers: headers);

    if (response.statusCode != HttpStatus.ok) {
      return false;
    } else {
      return true;
    }
  }
}
