import 'package:flutter/material.dart';

enum FriendQueryType {
  FRIENDS_WITH('FRIENDS_WITH'),
  FRIENDSHIP_REQUESTED('FRIENDSHIP_REQUESTED'),
  NO_RELATIONSHIP('NO_RELATIONSHIP');

  static FriendQueryType parse(String name) {
    for (FriendQueryType enumVariant in FriendQueryType.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return FriendQueryType.NO_RELATIONSHIP;
  }

  final String value;
  const FriendQueryType(this.value);
}
