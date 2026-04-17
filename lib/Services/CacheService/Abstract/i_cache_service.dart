import 'package:im_okay/Models/cached_user_data.dart';

abstract class ICacheService {
  String? getValue(String key);

  void setValue(String key, String value);

  String? getAuthToken();

  void setAuthToken(String token);

  void cacheUsers(List<CachedUserData> users);

  List<CachedUserData> fetchUsers();
}
