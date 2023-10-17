import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Services/router_service.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';
import 'package:im_okay_client/Utils/http_utils.dart';

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
        future: HttpUtils.sendGetRequest<User>('login'),
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
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          String username = usernameController.text;
                          String password = passwordController.text;
                          onButtonLoginClicked(username, password);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 70),
                            maximumSize: const Size(400, 200),
                            backgroundColor: Colors.deepPurpleAccent),
                        child: const Text(
                          LoginConsts.loginCaption,
                          textScaleFactor: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onButtonLoginClicked(String username, String password) async {
    bool loggedIn =
        await HttpUtils.loginAndStoreCredentials(username, password);
    if (loggedIn) {
      debugPrint('logging in!');
      RouterService.router.go("/report");
    }
  }
}
