import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  Future<void> storeAccessToken(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> fetchAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    return accessToken;
  }
}
