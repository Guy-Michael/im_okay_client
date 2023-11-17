import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/my_text_field.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
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
              DropdownMenu(
                label: const Text("מגדר"),
                controller: _genderController,
                menuStyle: const MenuStyle(alignment: Alignment.topRight),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: Gender.female, label: "נקבה"),
                  DropdownMenuEntry(value: Gender.male, label: "זכר")
                ],
              ),
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
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String gender = Gender.fromHebrew(_genderController.text);

    User user = User(
        firstName: firstName, lastName: lastName, email: email, gender: gender);

    await UserAuthenticationApiService.registerNewUser(
        password: password, user: user);

    await Future.delayed(const Duration(seconds: 2),
        () => globalRouter.go(Routes.authRedirectPage));

    // Fluttertoast.showToast(msg: "נרשמת בהצלחה!");
  }

  void navigateToLoginPage() async {
    globalRouter.push(Routes.authRedirectPage);
  }
}
