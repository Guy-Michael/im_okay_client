import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Widgets/purple_button.dart';

class PhoneVerificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PhoneVerificationPageState();
}

class PhoneVerificationPageState extends State<PhoneVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: TextField(
                  decoration: InputDecoration(hintText: Strings.PhoneVerificationInput),
                  keyboardType: TextInputType.phone,
                  autofillHints: ["Phone number"],
                  key: widget.key,
                ))),
        bottomSheet: ElevatedButton(
          onPressed: onClick,
          child: Text(Strings.PhoneVerificationPageButton),
        ));
  }

  onClick() async {
    // UserAuthenticationApiService.
  }
}
