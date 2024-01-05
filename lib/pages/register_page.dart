import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/Registration%20Page/registration_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RegistrationForm(
      onSubmit: completeRegistration,
    ));
  }

  void completeRegistration(User user, String password) async {
    await UserAuthenticationApiService.registerNewUser(password: password, user: user);

    await Future.delayed(
        const Duration(seconds: 2), () => globalRouter.go(Routes.authRedirectPage));

    // Fluttertoast.showToast(msg: "נרשמת בהצלחה!");
  }

  void navigateToLoginPage() async {
    globalRouter.push(Routes.authRedirectPage);
  }
}
