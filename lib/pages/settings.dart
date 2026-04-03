import 'dart:async';

import 'package:flutter/material.dart';
import 'package:im_okay/Models/alert_area.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/authentication_service.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/location_service.dart' as location_service;
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late IAuthenticationService _authService;

  @override
  void initState() {
    super.initState();

    _authService = serviceInjector.get<IAuthenticationService>();
  }

  Future<String> future() async {
    AlertArea area = await location_service.getUserAlertZone();
    return "${area.name} - ${area.id}";
  }

  @override
  Widget build(context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder<String>(
          future: future(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return Text(snapshot.data!);
          },
        )),
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
    await _authService.signOut();
  }

  Future<void> onDeleteUserButtonClicked() async {
    await _authService.deleteSignedInUserAndSignOut();

    globalRouter.go(Routes.auth.authRedirectPage);
  }
}

class SettingsPageConsts {
  static const String building = "בבנייה, יגיע בקרוב!";
  static const String logoutButtonCaption = "התנתקות";
  static const String deleteAccountButtonCaption = "מחיקת חשבון";
}
