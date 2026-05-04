enum NotificationTypeEnum {
  friendRequest("FriendRequest"),
  activeAlert("ActiveAlert"),
  invalid("Invalid");

  final String value;

  const NotificationTypeEnum(this.value);

  static NotificationTypeEnum parse(String name) {
    for (NotificationTypeEnum enumVariant in NotificationTypeEnum.values) {
      if (enumVariant.value == name) {
        return enumVariant;
      }
    }

    return NotificationTypeEnum.invalid;
  }
}
