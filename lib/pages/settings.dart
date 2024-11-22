import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/location_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late StreamController<AlertArea> alertAreaStreamController;

  @override
  void initState() {
    super.initState();
    alertAreaStreamController = StreamController<AlertArea>();
    alertAreaStreamController.addStream(getAlertAreaStream());
  }

  @override
  void dispose() {
    super.dispose();
    alertAreaStreamController.close();
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: StreamBuilder<AlertArea>(
          builder: (context, snapshot) {
            Widget child =
                snapshot.hasData ? Text(snapshot.data!.name) : CircularProgressIndicator.adaptive();

            return Center(
              child: child,
            );
          },
          stream: alertAreaStreamController.stream,
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
}

Future<void> onLogoutButtonClicked() async {
  await UserAuthenticationApiService.signOut();
}

Future<void> onDeleteUserButtonClicked() async {
  await UserAuthenticationApiService.deleteSignedInUserAndSignOut();

  globalRouter.go(Routes.authRedirectPage);
}

class SettingsPageConsts {
  static const String building = "בבנייה, יגיע בקרוב!";
  static const String logoutButtonCaption = "התנתקות";
  static const String deleteAccountButtonCaption = "מחיקת חשבון";
}
