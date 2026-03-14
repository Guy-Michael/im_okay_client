import 'package:flutter/material.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/pages/shared_components/go_to_add_kin_page_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      topComponent(),
      Expanded(
        child: Container(
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
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: GoToAddKinPageButton(),
      ),
    ]));
  }
}

Widget noAlertTitle() {
  return Text(
    _HomePageConsts.noAletsTitle,
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
        _HomePageConsts.noAlertsHelpText,
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

Widget topComponent() {
  return Container(
    padding: const EdgeInsets.only(top: 50, bottom: 20),
    decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
    child: Column(
      spacing: 8,
      children: [
        SizedBox(
          width: double.infinity,
          height: 28,
          child: Text(
            _HomePageConsts.topComponentTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: topComponentButton(),
        ),
      ],
    ),
  );
}

Widget topComponentButton() {
  return ElevatedButton.icon(
      label: Text(
        _HomePageConsts.topComponentButtonCaption,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 128, 0, 0),
          fontSize: 20,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () => globalRouter.pushReplacement(Routes.kin.addKin),
      icon: Icon(
        Icons.edit_square,
        size: 25,
        color: Color.fromARGB(255, 128, 0, 0),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 236, 212, 212)),
      ));
}

class _HomePageConsts {
  static const String noAletsTitle = "אין אזעקות אצלך ואצל הקרובים";
  static const String noAlertsHelpText =
      "אם הקרובים שלך יחוו אזעקה, כאן אפשר להתעדכן בשלומם ולעדכן אותם במצבך";
  static const String topComponentTitle = "הופעלה אזעקה?";
  static const String topComponentButtonCaption = "עדכן סטאטוס";
}
