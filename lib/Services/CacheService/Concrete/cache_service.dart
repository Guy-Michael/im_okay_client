import 'dart:convert';

import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:im_okay/Models/cached_user_data.dart';
import 'package:im_okay/Services/CacheService/Abstract/i_cache_service.dart';
import 'package:im_okay/Utils/encryption_utils.dart';
import 'package:localstorage/localstorage.dart';

class CacheService implements ICacheService {
  CacheService();
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

  @override
  void cacheUsers(List<CachedUserData> users) {
    String encoded = jsonEncode(users);
    String encrypted = EncryptionUtils.encryptBase64(encoded);
    localStorage.setItem(StorageKeys.users.toString(), encrypted);
  }

  @override
  List<CachedUserData> fetchUsers({bool kinOnly = false}) {
    String encrypted = localStorage.getItem(StorageKeys.users.toString()) ?? '';
    if (encrypted == '') {
      return [];
    }

    String decrypted = EncryptionUtils.decryptBase64(encrypted);
    List list = jsonDecode(decrypted);
    var users = list.map((item) => CachedUserData.fromJson(item));
    if (kinOnly) {
      users = users.where((user) => user.relationship == Relationship.friendsWith);
    }
    return users.toList();
  }
}

enum StorageKeys { authToken, users }
