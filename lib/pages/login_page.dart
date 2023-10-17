import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';
import 'package:im_okay_client/Utils/storage_utils.dart';
import 'package:im_okay_client/Widgets/purple_button.dart';
import 'package:im_okay_client/Widgets/my_text_field.dart';

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
    return FutureBuilder<User?>(
        future: StorageUtils.fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint(snapshot.data!.username);
            context.go('/reports');
            return Container();
          } else {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      MyTextField(usernameController, Consts.username),
                      const SizedBox(height: 20),
                      MyTextField(
                        passwordController,
                        Consts.password,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PurpleButton(
                                callback: onButtonRegisterClicked,
                                caption: Consts.registerCaption),
                            const SizedBox(width: 20),
                            PurpleButton(
                                callback: onButtonLoginClicked,
                                caption: Consts.loginCaption)
                          ])
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  void onButtonLoginClicked() async {
    String username = usernameController.text;
    String password = passwordController.text;
    bool loggedIn =
        await HttpUtils.loginAndStoreCredentials(username, password);
    if (loggedIn) {
      debugPrint('logging in!');
      RouterService.router.go(Routes.reportsPage);
    }
  }

  void onButtonRegisterClicked() {
    RouterService.router.go(Routes.registrationPage);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
