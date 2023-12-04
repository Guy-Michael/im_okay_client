class Consts {
  static const String appName = "I'm Okay";
  static const String loginCaption = r'התחברות';
  static const String registerCaption = r'הרשמה';
  static const String cancel = "ביטול";
  static const String username = "שם משתמש";

  static const String reportedSuccessfully = "שיתפת בהצלחה";
  static String logoutButtonCaption(String gender) => gender == Gender.female ? "התנתקי" : "התנתק";

  static String deleteUserButtonCaption(String gender) =>
      gender == Gender.female ? "מחקי את חשבונך" : "מחק את חשבונך";
  static String reportButtonCaption(String nameHeb, String gender) {
    return "${gender == Gender.female ? "שתפי שאת בטוחה" : "שתף שאתה בטוח"} ❤️";
  }

  static const String justNow = "לפני רגע";
  static String notReportedYet(String gender) {
    return gender == Gender.female ? "לא שיתפה עדיין" : "לא שיתף עדיין";
  }

  static String xTimeAgo(Duration deltaSince) {
    String result = 'לפני ';
    if (deltaSince.inDays > 1) {
      result += "${deltaSince.inDays} ימים";
    } else if (deltaSince.inHours > 1) {
      result += "${deltaSince.inHours} שעות";
    } else if (deltaSince.inMinutes > 1) {
      result += "${deltaSince.inMinutes} דקות";
    } else {
      result += "רגע";
    }

    return result;
  }

  static const String firstName = "שם פרטי";
  static const String lastName = "שם משפחה";

  static const String password = "סיסמה";
  static const String email = "אימייל";

  static const String searchFriendsFieldHintText = "חפשו חברים";
}

class Gender {
  static const String male = "male";
  static const String female = "female";
  static const String maleHeb = 'זכר';
  static const String femaleHeb = 'נקבה';
  static String fromHebrew(String genderInHebrew) {
    return genderInHebrew == "נקבה" ? female : male;
  }
}

class Routes {
  static const String authRedirectPage = "/auth";
  static const String reportsPage = "report";
  static const String registrationPage = '/register';
  static const String settings = '/settings';
  static const String friendRequests = "/requests";
  static const String addFriendsPage = 'add-friends';
  static const String hub = '/hub';
}
