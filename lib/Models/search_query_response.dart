import 'dart:convert';

import 'package:im_okay/Enums/relationship_enum.dart';
import 'package:im_okay/Models/app_user.dart';

class SearchQueryResponse {
  AppUser user;
  Relationship relationship;

  SearchQueryResponse({required this.user, required this.relationship});

  static List<SearchQueryResponse> parseList(String json) {
    List dynamicList = jsonDecode(json);
    List<SearchQueryResponse> response = dynamicList.map(parseSingle).toList();
    return response;
  }

  static SearchQueryResponse parseSingle(dynamic obj) {
    return SearchQueryResponse(
        user: AppUser.fromJson(obj['user']), relationship: Relationship.parse(obj['relationship']));
  }
}
