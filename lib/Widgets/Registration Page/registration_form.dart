import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Utils/Consts/color_consts.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

final _formKey = GlobalKey<FormState>();

class RegistrationForm extends StatefulWidget {
  Function(User user, String password) onSubmit;
  Function() onCancel;
  final User _user = User();
  String _password = '';

  RegistrationForm({super.key, required this.onSubmit, required this.onCancel});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: RegistrationConstants.firstNameHint),
                  validator: (value) => (value!.isEmpty)
                      ? RegistrationConstants.firstNameValidationMessage
                      : null,
                  onSaved: (value) {
                    widget._user.firstName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: RegistrationConstants.lastNameHint),
                  validator: (value) => (value!.isEmpty)
                      ? RegistrationConstants.lastNameValidationMessage
                      : null,
                  onSaved: (value) {
                    widget._user.lastName = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: RegistrationConstants.emailHint),
                  validator: (value) =>
                      (!RegistrationConstants.emailRegexp.hasMatch(value!))
                          ? RegistrationConstants.emailValidationMessage
                          : null,
                  onSaved: (value) {
                    widget._user.email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: RegistrationConstants.passwordHint),
                  onSaved: (value) {
                    widget._password = value!;
                  },
                  validator: (value) =>
                      (!RegistrationConstants.passwordRegExp.hasMatch(value!))
                          ? RegistrationConstants.passwordValidationMessage
                          : null,
                ),
                DropdownButtonFormField(
                    onSaved: (value) {
                      widget._user.gender = value!;
                    },
                    value: null,
                    hint: const Text(RegistrationConstants.genderHint),
                    validator: (value) => value == null
                        ? RegistrationConstants.genderValidationMessage
                        : null,
                    items: const [
                      DropdownMenuItem(
                        value: Gender.female,
                        child: Text(Gender.femaleHeb),
                      ),
                      DropdownMenuItem(
                          value: Gender.male, child: Text(Gender.maleHeb)),
                    ],
                    onChanged: (a) {}),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PurpleButton(
                          showProgressIndicatorAfterClick: true,
                          onClick: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();
                            debugPrint(widget._user.toString());
                            await widget.onSubmit(
                                widget._user, widget._password);
                          },
                          caption: RegistrationConstants.submitButtonText),
                      PurpleButton(
                        caption: RegistrationConstants.cancelButtonText,
                        color: ColorConsts.secondaryButton,
                        onClick: () => widget.onCancel(),
                      )
                    ])
              ],
            ))
        // )
      ]),
    );
  }
}

class RegistrationConstants {
  static const String firstNameHint = 'שם פרטי';
  static const String lastNameHint = 'שם משפחה';
  static const String passwordHint = 'סיסמה';
  static const String emailHint = 'כתובת אי-מייל';
  static const String genderHint = 'לשון פניה';
  static const String submitButtonText = 'הרשמה';
  static const String cancelButtonText = 'ביטול';
  static final RegExp passwordRegExp =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$');
  static const String passwordValidationMessage =
      'תנאים לסיסמה: לפחות 6 תווים, לפחות אות קטנה אחת ואות גדולה אחת';
  static final RegExp emailRegexp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static const String emailValidationMessage =
      'נא להכניס כתובת אי-מייל תקינה, לדוגמא: me@imokay.com';
  static const String firstNameValidationMessage = 'נא להכניס שם פרטי';
  static const String lastNameValidationMessage = 'נא להכניס שם משפחה';
  static const String genderValidationMessage = 'נא לבחור לשון פנייה';
}
