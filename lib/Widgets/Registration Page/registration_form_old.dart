import 'dart:core';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class RegistrationForm2 extends StatelessWidget {
  Function(User user, String password) callback;
  RegistrationForm2({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GfForm(
        onFormSubmitted: (list) {
          debugPrint(list.toString());
        },
        formfields: [
          GfFormField(
            gfFormFieldType: GfFormFieldType.text,
            hintText: RegistrationConstants.firstNameHint,
            validator: GfFormValidators().getnamevalidator(
                length: 0, emptyErrorText: RegistrationConstants.firstNameValidationMessage),
          ),
          GfFormField(
            gfFormFieldType: GfFormFieldType.text,
            hintText: RegistrationConstants.lastNameHint,
            validator: GfFormValidators().getnamevalidator(
                length: 0, emptyErrorText: RegistrationConstants.lastNameValidationMessage),
          ),
          GfFormField(
              gfFormFieldType: GfFormFieldType.email,
              hintText: RegistrationConstants.emailHint,
              validator: GfFormValidators()
                  .getemailvalidator(emptyErrorText: RegistrationConstants.emailValidationMessage)),
          GfFormField(
              gfFormFieldType: GfFormFieldType.password,
              hintText: RegistrationConstants.passwordHint,
              validator: GfFormValidators().getpasswordvalidator(
                  errorText: RegistrationConstants.passwordValidationMessage,
                  emptyErrorText: RegistrationConstants.passwordValidationMessage)),
          const GfFormDropDown(
              values: [Gender.femaleHeb, Gender.maleHeb],
              hintText: RegistrationConstants.genderHint),
        ],
        defaultSubmitButtonEnabled: true);
  }
}

class RegistrationConstants {
  static const String firstNameHint = 'שם פרטי';
  static const String lastNameHint = 'שם משפחה';
  static const String passwordHint = 'סיסמה';
  static const String emailHint = 'כתובת אי-מייל';
  static const String genderHint = 'לשון פניה';
  static const String submitButtonText = 'הרשמה';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$';
  static const String passwordValidationMessage =
      'תנאים לסיסמה: לפחות 6 תווים, לפחות אות קטנה אחת ואות גדולה אחת';
  static const String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String emailValidationMessage =
      'נא להכניס כתובת אי-מייל תקינה, לדוגמא: me@imokay.com';
  static const String genderValidationMessage = "נא לבחור מגדר";
  static const String firstNameValidationMessage = 'נא להכניס שם פרטי';
  static const String lastNameValidationMessage = 'נא להכניס שם משפחה';
}
