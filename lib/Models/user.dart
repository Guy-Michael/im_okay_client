import 'package:equatable/equatable.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class AppUser extends Equatable {
  String email;
  String firstName;
  String lastName;
  String gender;
  int lastSeen;

  String get fullName => "$firstName $lastName";
  bool get isFemale => gender == Gender.female;

  AppUser(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.lastSeen = 0,
      this.gender = ''});

  AppUser.fromJson(Map<String, dynamic> json)
      : email = getValueOrDefault(json, 'email'),
        firstName = getValueOrDefault(json, 'firstName'),
        lastName = getValueOrDefault(json, 'lastName'),
        lastSeen = getValueOrDefault(json, 'lastSeen'),
        gender = getValueOrDefault(json, 'gender');

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'lastSeen': lastSeen,
      'gender': gender
    };
  }

  static dynamic getValueOrDefault(Map<String, dynamic> json, key) {
    return json.containsKey(key) && json[key] != null ? json[key] : '';
  }

  @override
  List<Object?> get props => [firstName, lastName, email, gender, lastSeen];
}
