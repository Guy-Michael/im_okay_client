import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: PurpleButton(onClick: onButtonLoginClicked, caption: "Google Signin!")));
    // 			ElevatedButton(
    // onPressed: onButtonLoginClicked,
    // child: Text(_LoginConsts.loginButtonCaption),
    // )));
  }

  Future<void> onButtonLoginClicked() async {
    bool success = await UserAuthenticationApiService.registerOrSignIn();
    if (success) {
      InAppMessageService.showToast(message: _LoginConsts.loginSuccessfullMessage);
      globalRouter.push(Routes.hub);
    } else {
      InAppMessageService.showToast(message: _LoginConsts.loginFailed);
    }
  }
}

class _LoginConsts {
  static const String loginButtonCaption = 'התחברות עם גוגל';
  static const String loginSuccessfullMessage = "התחברת בהצלחה!";
  static const String loginFailed = "התחברות נכשלה :(";
}
