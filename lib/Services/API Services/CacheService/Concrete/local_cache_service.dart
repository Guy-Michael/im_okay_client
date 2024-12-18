import 'package:im_okay/Services/API%20Services/CacheService/Abstract/cache_service.dart';
import 'package:localstorage/localstorage.dart';

class LocalCacheService implements CacheService {
  LocalCacheService();
  @override
  String? getValue(String name) {
    String? key = localStorage.getItem(name);
    return key;
  }

  @override
  String? getAuthToken() => getValue(StorageKeys.authToken.name);

  @override
  void setAuthToken(String token) {
    localStorage.setItem(StorageKeys.authToken.name, token);
  }

  @override
  void setValue(String key, String value) {
    localStorage.setItem(key, value);
  }
}

enum StorageKeys { authToken }
