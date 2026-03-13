import 'package:flutter/material.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_management_button.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';

class KinManagementPage extends StatefulWidget {
  const KinManagementPage({super.key});

  @override
  State<StatefulWidget> createState() => _KinManagementPageState();
}

class _KinManagementPageState extends State<KinManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Column(spacing: 32, children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 58, 0, 0),
      ),
      KinPageTitle(title: _KinManagementPageConsts.pageTitle),
      KinManagementButton(
        destination: Routes.kin.myKin,
        label: _KinManagementPageConsts.myKinPageTitle,
        icon: Icons.people_alt_outlined,
      ),
      KinManagementButton(
        destination: Routes.kin.addKin,
        label: _KinManagementPageConsts.addKinPageTitle,
        icon: Icons.add,
      ),
      KinManagementButton(
        destination: Routes.kin.kinRequests,
        label: _KinManagementPageConsts.newKinRequestsPageTitle,
        icon: Icons.account_box_sharp,
      ),
    ]);
  }
}

class _KinManagementPageConsts {
  static const String pageTitle = "ניהול קרובים";
  static const String myKinPageTitle = "הקרובים שלי";
  static const String addKinPageTitle = "הוספת קרובים";
  static const String newKinRequestsPageTitle = "בקשות חדשות";
}
