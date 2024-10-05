import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:im_okay/Models/user.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    return FutureBuilder<String>(future: () async {
      AppUser user = (await UserAuthenticationApiService.appUser)!;
      return user.gender;
    }(), builder: (context, snapshot) {
      return Scaffold(
          body: const Center(child: Text("בבנייה, יגיע בקרוב!")),
          bottomSheet: Center(
              heightFactor: 1,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PurpleButton(
                          onClick: onLogoutButtonClicked,
                          caption: "התנתקות",
                          color: Colors.grey,
                        ),
                        PurpleButton(onClick: onDeleteUserButtonClicked, caption: "מחיקת חשבון"),
                      ]))));
    });
  }

  Future<void> onLogoutButtonClicked() async {
    await auth.FirebaseAuth.instance.signOut();
    globalRouter.push(Routes.authRedirectPage);
  }

  Future<void> onDeleteUserButtonClicked() async {
    await UserAuthenticationApiService.deleteSignedInUser();

    globalRouter.go(Routes.authRedirectPage);
  }
}
