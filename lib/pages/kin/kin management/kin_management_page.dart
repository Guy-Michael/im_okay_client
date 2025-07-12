import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_management_button.dart';

class KinManagementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KinManagementPageState();
}

class _KinManagementPageState extends State<KinManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(spacing: 32, children: [
          Text(
            "ניהול קרובים",
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          KinManagementButton(
            destination: "",
            label: "הקרובים שלי",
            icon: Icons.account_box_sharp,
          ),
          KinManagementButton(
            destination: "",
            label: "הוספת קרובים",
            icon: Icons.account_box_sharp,
          ),
          KinManagementButton(
            destination: "",
            label: "בקשות חדשות",
            icon: Icons.account_box_sharp,
          ),
        ]));
  }
}
