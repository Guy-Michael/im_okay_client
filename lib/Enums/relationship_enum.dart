enum Relationship {
  friendsWith('FRIENDS_WITH'),
  friendshipRequested('FRIENDSHIP_REQUESTED'),
  noRelationship('NO_RELATIONSHIP');

  static Relationship parse(String name) {
    for (Relationship enumVariant in Relationship.values) {
      if (enumVariant.value == name) {
        return enumVariant;
      }
    }
    return Relationship.noRelationship;
  }

  final String value;
  const Relationship(this.value);
}
