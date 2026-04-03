import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  late IAuthenticationService _authService;
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    _authService = serviceInjector.get<IAuthenticationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: PurpleButton(
                onClick: () => onButtonLoginClicked(context), caption: "Google Signin!")));
  }

  Future<void> onButtonLoginClicked(BuildContext ctx) async {
    bool success = await _authService.registerOrSignIn();
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
