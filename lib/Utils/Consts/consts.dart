class LoginConsts {
  static const String loginCaption = r'התחבר\י';
}

class ReportsPageConsts {
  static const String reportedSuccessfully = "שיתפת בהצלחה";
  static String reportButtonCaption(String nameHeb, String gender) {
    String result = "$nameHeb, ";
    return "❤️ $result${gender == Gender.female ? "שתפי שאת בטוחה" : "שתף שאתה בטוח"}";
  }
}

class LastSeenConsts {
  static const String justNow = "לפני רגע";
  static String notReportedYet(String gender) {
    return gender == Gender.female ? "לא שיתפה עדיין" : "לא שיתף עדיין";
  }

  static String xMinutesAgo(int minutes) {
    return 'לפני $minutes דקות';
  }
}

class Gender {
  static const String male = "male";
  static const String female = "female";
}
