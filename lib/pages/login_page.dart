import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/http_utils.dart';
import 'package:im_okay/Widgets/purple_button.dart';
import 'package:im_okay/Widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            MyTextField(
                inputController: usernameController, hintText: Consts.username),
            const SizedBox(height: 20),
            MyTextField(
              inputController: passwordController,
              hintText: Consts.password,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              PurpleButton(
                  callback: () => onButtonRegisterClicked(context),
                  caption: Consts.registerCaption),
              const SizedBox(width: 20),
              PurpleButton(
                  callback: onButtonLoginClicked, caption: Consts.loginCaption)
            ])
          ],
        ),
      ),
    ));
  }

  void onButtonLoginClicked() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    //NEW SIGNIN USING FIREBASE
    bool succeeded =
        await HttpUtils.validateLogin(username: username, password: password);

    if (succeeded) {
      // User user = await HttpUtils.getFullLoggedInUserDate();

      var claims =
          (await auth.FirebaseAuth.instance.currentUser?.getIdTokenResult())
              ?.claims;

      debugPrint(claims?['firstName']);
      debugPrint(claims?['lastName']);
      debugPrint(claims?['gender']);
    }
    globalRouter.push(Routes.hub);
  }

  void onButtonRegisterClicked(BuildContext context) {
    globalRouter.push(Routes.registrationPage);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
