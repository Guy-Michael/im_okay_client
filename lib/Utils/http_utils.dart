import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:im_okay/Services/ApiServices/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/Logger/my_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:im_okay/Services/service_injector.dart';

// var logger = Logger();

class HttpUtils {
  static final IAuthenticationService _authService = serviceInjector.get<IAuthenticationService>();

  static Uri composeUri({required String endpoint, Map<String, Object>? queryParams}) {
    String url = dotenv.get('serverUrl');
    Uri uri = Uri.http(url, endpoint, queryParams);

    return uri;
  }

  static Future<Map<String, String>> _getHeaders() async {
    String idToken = await _authService.getFirebaseAuthToken();
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
    log1(uri, headers);
    http.Response response = await http.post(uri, body: bodyString, headers: headers);

    log2(response);
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

    log1(uri, headers);
    log2(response);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Get request failed with stats ${response.statusCode}');
    }

    return response.body;
  }

  static Future<bool> delete({required endpoint}) async {
    Map<String, String> headers = await _getHeaders();
    Uri uri = composeUri(endpoint: endpoint);

    log1(uri, headers);

    http.Response response = await http.delete(uri, headers: headers);
    log2(response);

    if (response.statusCode != HttpStatus.ok) {
      return false;
    } else {
      return true;
    }
  }

  static void log1(Uri uri, Map<String, String> headers) {
    logger.log('***********************************');
    logger.log("uri: $uri");
    // logger.log("headers: $headers");
  }

  static void log2(http.Response response) {
    logger.log("response: ${response.statusCode}: ${response.body}");
    logger.log('***********************************');
  }
}
