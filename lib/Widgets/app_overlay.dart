import 'package:flutter/material.dart';

class AppOverlay extends StatelessWidget {
  late Widget body;

  AppOverlay({body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
        ),
        body: body,
        bottomNavigationBar: Container(
          color: Colors.pink,
        ));
  }
}
