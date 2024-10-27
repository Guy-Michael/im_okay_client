import 'dart:convert';

import 'package:im_okay/Enums/friend_query_type_enum.dart';
import 'package:im_okay/Models/user.dart';

class SearchQueryResponse {
  AppUser user;
  FriendQueryType relationship;

  SearchQueryResponse({required this.user, required this.relationship});

  static List<SearchQueryResponse> parseList(String json) {
    List dynamicList = jsonDecode(json);
    List<SearchQueryResponse> response = dynamicList.map(parseSingle).toList();
    return response;
  }

  static SearchQueryResponse parseSingle(dynamic obj) {
    return SearchQueryResponse(
        user: AppUser.fromJson(obj['user']),
        relationship: FriendQueryType.parse(obj['relationship']));
  }
}
