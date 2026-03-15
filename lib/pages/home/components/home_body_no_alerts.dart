import 'package:flutter/material.dart';
import 'package:im_okay/pages/shared_components/go_to_add_kin_page_button.dart';

class HomeBodyNoAlerts extends StatefulWidget {
  const HomeBodyNoAlerts({super.key});

  @override
  State<StatefulWidget> createState() => HomeBodyNoAlertsState();
}

class HomeBodyNoAlertsState extends State<HomeBodyNoAlerts> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 28, left: 16, right: 16, bottom: 28),
        child: Column(
          spacing: 32,
          children: [
            noAlertTitle(),
            helpText(),
            Image(image: AssetImage("Assets/Main/main_page_no_alarms.png")),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: GoToAddKinPageButton(),
      ),
    ]);
  }
}

Widget noAlertTitle() {
  return Text(
    _HomeBodyNoAlertsConsts.noAletsTitle,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget helpText() {
  return SizedBox(
    width: 305,
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: 305),
      child: Text(
        _HomeBodyNoAlertsConsts.noAlertsHelpText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF7B7B7B),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

class _HomeBodyNoAlertsConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
}
