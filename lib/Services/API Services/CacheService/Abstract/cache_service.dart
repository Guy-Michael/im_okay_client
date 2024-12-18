abstract class CacheService {
  String? getValue(String key);
  void setValue(String key, String value);

  String? getAuthToken();
  void setAuthToken(String token);
}
