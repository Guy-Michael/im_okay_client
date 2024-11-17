import 'package:flutter/material.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/location_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    // return FutureBuilder<String>(
    //   future: getAlertZoneName(),-
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return CircularProgressIndicator();
    //     }

    //     return Container(child: Text(snapshot.data!));
    //   },
    // );

    return Scaffold(
        body: FutureBuilder(
          future: getAlertZoneName(),
          builder: (context, snapshot) {
            Widget child =
                snapshot.hasData ? Text(snapshot.data!) : CircularProgressIndicator.adaptive();

            return Center(
              child: child,
            );
          },
        ),
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
                        caption: SettingsPageConsts.logoutButtonCaption,
                        color: Colors.grey,
                      ),
                      PurpleButton(
                          onClick: onDeleteUserButtonClicked,
                          caption: SettingsPageConsts.deleteAccountButtonCaption),
                    ]))));
  }

  Future<void> onLogoutButtonClicked() async {
    await UserAuthenticationApiService.signOut();
  }

  Future<void> onDeleteUserButtonClicked() async {
    await UserAuthenticationApiService.deleteSignedInUserAndSignOut();

    globalRouter.go(Routes.authRedirectPage);
  }

  Future<String> getAlertZoneName() async {
    String alertAreaName = await LocationService.getUserAlertZone();
    return alertAreaName;
  }
}

class SettingsPageConsts {
  static const String building = "בבנייה, יגיע בקרוב!";
  static const String logoutButtonCaption = "התנתקות";
  static const String deleteAccountButtonCaption = "מחיקת חשבון";
}
