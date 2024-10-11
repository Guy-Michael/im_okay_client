import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
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
        body: Container(
            height: 500,
            width: 500,
            child: PurpleButton(onClick: onButtonLoginClicked, caption: "Google Signin!")));
  }

  Future<void> onButtonLoginClicked() async {
    await UserAuthenticationApiService.registerOrSignIn();
    //   if (loggedIn) {
    //     InAppMessageService.showToast(message: _LoginConsts.loginSuccessfullMessage);
    //     globalRouter.push(Routes.hub);
    //   }
    // }
  }

  void onButtonRegisterClicked(BuildContext context) {
    globalRouter.push(Routes.registrationPage);
  }
}

class _LoginConsts {
  static const String loginSuccessfullMessage = "התחברת בהצלחה!";
}
