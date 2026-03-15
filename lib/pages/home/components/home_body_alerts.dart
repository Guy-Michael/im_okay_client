import 'package:flutter/material.dart';

class HomeBodyWithAlerts extends StatefulWidget {
  const HomeBodyWithAlerts({super.key});

  @override
  State<StatefulWidget> createState() => HomeBodyWithAlertsState();
}

class HomeBodyWithAlertsState extends State<HomeBodyWithAlerts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("Responded \\ not responded toggle here"), Text("People list here")],
    );
  }
}

class _HomeBodyWithAlertsConsts {}
