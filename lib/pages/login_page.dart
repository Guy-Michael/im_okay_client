import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
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
    // globalRouter.go("")

    return Scaffold(
        body: Center(
            child: PurpleButton(
                onClick: () => onButtonLoginClicked(context), caption: "Google Signin!")));
    // 			ElevatedButton(
    // onPressed: onButtonLoginClicked,
    // child: Text(_LoginConsts.loginButtonCaption),
    // )));
  }

  Future<void> onButtonLoginClicked(BuildContext ctx) async {
    bool success = await UserAuthenticationApiService.registerOrSignIn();
    if (success) {
      if (!mounted) return;
      InAppMessageService.showToast(message: _LoginConsts.loginSuccessfullMessage);

      ctx.goNamed(Routes.kin.kinManagement);
    } else {
      if (!mounted) return;
      InAppMessageService.showToast(message: _LoginConsts.loginFailed);
    }
  }
}

class _LoginConsts {
  static const String loginButtonCaption = 'התחברות עם גוגל';
  static const String loginSuccessfullMessage = "התחברת בהצלחה!";
  static const String loginFailed = "התחברות נכשלה :(";
}
