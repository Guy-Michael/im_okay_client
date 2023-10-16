class ReportsPageConsts {
  static const String reportedSuccessfully = "שיתפת בהצלחה";
  static String reportButtonCaption(String gender) {
    return gender == Gender.female ? "❤️ שתפי שאת בטוחה" : "❤️ שתף שאתה בטוח";
  }
}

class Gender {
  static const String male = "male";
  static const String female = "female";
}
