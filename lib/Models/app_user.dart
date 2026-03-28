import 'package:equatable/equatable.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class AppUser extends Equatable {
  String uid;
  String email;
  String firstName;
  String lastName;
  String imageUrl;
  String gender;
  int lastSeen;
  int lastAlertTime;

  String get fullName => "$firstName $lastName";
  bool get isFemale => gender == Gender.female;
  bool get hasReportedSafeDuringAlert {
    return lastSeen > lastAlertTime;
  }

  AppUser(
      {this.uid = '',
      this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.lastSeen = 0,
      this.lastAlertTime = 0,
      this.imageUrl = '',
      this.gender = ''});

  AppUser.fromJson(Map<String, dynamic> json)
      : uid = getValueOrDefault(json, 'uid'),
        email = getValueOrDefault(json, 'email'),
        firstName = getValueOrDefault(json, 'firstName'),
        lastName = getValueOrDefault(json, 'lastName'),
        lastSeen = getValueOrDefault(json, 'lastSeen'),
        lastAlertTime = getValueOrDefault(json, 'lastAlertTime'),
        imageUrl = getValueOrDefault(json, 'imageUrl'),
        gender = getValueOrDefault(json, 'gender');

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'lastSeen': lastSeen,
      'lastAlertTime': lastAlertTime,
      'imageUrl': imageUrl,
      'gender': gender
    };
  }

  static dynamic getValueOrDefault(Map<String, dynamic> json, key) {
    return json.containsKey(key) && json[key] != null ? json[key] : '';
  }

  Duration durationSinceLastAlert() {
    DateTime lastAlertDate = DateTime.fromMillisecondsSinceEpoch(lastAlertTime * 1000);
    return DateTime.now().difference(lastAlertDate);
  }

  Duration durationSinceLastSeen() {
    DateTime lastSeenDate = DateTime.fromMillisecondsSinceEpoch(lastSeen * 1000);
    return DateTime.now().difference(lastSeenDate);
  }

  @override
  List<Object?> get props =>
      [uid, firstName, lastName, email, gender, lastSeen, lastAlertTime, imageUrl];
}
