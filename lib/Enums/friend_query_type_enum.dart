enum FriendQueryType {
  friendsWith('FRIENDS_WITH'),
  friendshipRequested('FRIENDSHIP_REQUESTED'),
  noRelationship('NO_RELATIONSHIP');

  static FriendQueryType parse(String name) {
    for (FriendQueryType enumVariant in FriendQueryType.values) {
      if (enumVariant.name == name) {
        return enumVariant;
      }
    }
    return FriendQueryType.noRelationship;
  }

  final String value;
  const FriendQueryType(this.value);
}
