import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final int lastSeen;

  String get fullName => "$firstName $lastName";

  const User(
      {this.email = '',
      this.firstName = '',
      this.lastName = '',
      this.lastSeen = 0,
      this.gender = ''});

  User.fromJson(Map<String, dynamic> json)
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
