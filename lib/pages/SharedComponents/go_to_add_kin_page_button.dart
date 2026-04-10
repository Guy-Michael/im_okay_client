import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Styles/text_styles.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class GoToAddKinPageButton extends StatefulWidget {
  const GoToAddKinPageButton({super.key});

  @override
  State<StatefulWidget> createState() => GoToAddKinPageButtonState();
}

class GoToAddKinPageButtonState extends State<GoToAddKinPageButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        label: Text(
          _GoToAddAddKinPageButtonConsts.buttonCaption,
          textAlign: TextAlign.center,
          style: TextStyles.subHeader,
        ),
        onPressed: () => context.replaceNamed(Routes.kin.addKin),
        icon: Icon(Icons.add_circle, color: Colors.teal),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color.fromARGB(0, 0, 0, 0)),
            shadowColor: WidgetStateProperty.all(Color.fromARGB(0, 0, 0, 0))));
  }
}

class _GoToAddAddKinPageButtonConsts {
  static const String buttonCaption = "הוספת קרובים";
}
