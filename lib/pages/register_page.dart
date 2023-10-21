import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Widgets/my_text_field.dart';
import 'package:im_okay_client/Widgets/purple_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyTextField(
                  inputController: _firstNameController,
                  hintText: Consts.firstName),
              MyTextField(
                  inputController: _lastNameController,
                  hintText: Consts.lastName),
              MyTextField(
                  inputController: _passwordController,
                  hintText: Consts.password),
              MyTextField(
                  inputController: _emailController, hintText: Consts.email),
              const SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                PurpleButton(
                    callback: navigateToLoginPage, caption: Consts.cancel),
                const SizedBox(
                  width: 50,
                ),
                PurpleButton(
                    callback: completeRegistration,
                    caption: Consts.registerCaption),
              ])
            ],
          ),
        ),
      ),
    );
  }

  void completeRegistration() async {
    debugPrint(
        'name: ${_firstNameController.text}, password: ${_passwordController.text}, email: ${_emailController.text}');

    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String fullName = '$firstName $lastName';

    var a = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    globalRouter.go(Routes.authRedirectPage);
    // await HttpUtils.registerNewUser(fullName, email, password);
  }

  void navigateToLoginPage() async {
    globalRouter.push(Routes.authRedirectPage);
  }
}
