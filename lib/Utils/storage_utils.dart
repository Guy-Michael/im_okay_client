import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String _accessTokenStorageKey = "accessToken";
  static Future<void> storeAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenStorageKey, accessToken);
  }

  static Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    return accessToken;
  }
}
