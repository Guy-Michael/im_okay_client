import 'package:flutter/material.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

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
                  decoration: InputDecoration(hintText: Strings.phoneVerificationInput),
                  keyboardType: TextInputType.phone,
                  autofillHints: ["Phone number"],
                  key: widget.key,
                ))),
        bottomSheet: ElevatedButton(
          onPressed: onClick,
          child: Text(Strings.phoneVerificationPageButton),
        ));
  }

  onClick() async {
    // UserAuthenticationApiService.
  }
}
