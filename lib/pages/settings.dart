import 'package:flutter/material.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: const Center(child: Text("בבנייה, יגיע בקרוב!")),
      bottomSheet: Center(
          heightFactor: 1,
          child: PurpleButton(
              callback: onLogoutButtonClicked,
              caption: Consts.logoutButtonCaption(Gender.female))),
    );
  }

  void onLogoutButtonClicked() async {
    await FirebaseAuth.instance.signOut();
    globalRouter.push(Routes.authRedirectPage);
  }
}
