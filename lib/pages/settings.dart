import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Services/location_service.dart' as location_service;
import 'package:im_okay/Services/location_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late StreamController<AlertArea>? alertAreaStreamController;

  @override
  void initState() {
    super.initState();
    alertAreaStreamController = StreamController<AlertArea>();
    alertAreaStreamController?.addStream(location_service.getAlertAreaStream());
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('disposing streams');
    alertAreaStreamController?.close();
    alertAreaStreamController = null;
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: Consumer<LocationProvider>(
          builder: (context, value, child) {
            return Center(child: Text(value.alertArea.name));
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
}

Future<void> onLogoutButtonClicked() async {
  // debugPrint(await FirebaseMessaging.instance.getToken());
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
