// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/Notification%20Services/in_app_message_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';
import 'package:im_okay/Widgets/my_text_field.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SignInScreen(
      providers: [
        GoogleProvider(
          clientId: "WEB",
        )
      ],
    )
        // body: Center(
        //   child: SizedBox(
        //     height: 50,
        //     child: SignInButton(Buttons.google,
        //         text: "Sign in with google", onPressed: _handleGoogleSignin),
        //   ),
        // ),
        // 		Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: <Widget>[
        //         MyTextField(inputController: usernameController, hintText: Consts.username),
        //         MyTextField(
        //           inputController: passwordController,
        //           hintText: Consts.password,
        //           obscureText: true,
        //         ),
        //         Padding(
        //             padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        //             child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //               PurpleButton(
        //                   onClick: () async => onButtonRegisterClicked(context),
        //                   caption: Consts.registerCaption),
        //               const SizedBox(width: 20),
        //               PurpleButton(
        //                 onClick: onButtonLoginClicked,
        //                 caption: Consts.loginCaption,
        //                 showProgressIndicatorAfterClick: true,
        //               ),
        //             ]))
        //       ],
        //     ),
        //   ),
        // )
        );
  }

  Future<void> onButtonLoginClicked() async {
    // String username = usernameController.text.trim();
    // String password = passwordController.text.trim();

    // bool authenticationSuccessfull = await UserAuthenticationApiService.validateLoginAndGetUserData(
    //     username: username, password: password);
    // if (authenticationSuccessfull) {
    //   InAppMessageService.showToast(message: _LoginConsts.loginSuccessfullMessage);
    //   globalRouter.push(Routes.hub);
    // }
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

  // void _handleGoogleSignin() async {
  //   try {
  //     GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
  //     await _auth.signInWithProvider(googleAuthProvider);
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }
}

class _LoginConsts {
  static const String loginSuccessfullMessage = "התחברת בהצלחה!";
}
