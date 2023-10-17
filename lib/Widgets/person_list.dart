import 'package:flutter/material.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';

class PersonList extends StatelessWidget {
  final List<User> users;
  const PersonList(this.users, {super.key});

  List<PersonWidget> generatePersonList() {
    return users.map((User u) {
      return PersonWidget(u.nameHeb, u.lastSeen, u.gender);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: generatePersonList());
  }
}

class PersonWidget extends StatefulWidget {
  final String name;
  final String gender;
  final int? lastSeen;

  const PersonWidget(this.name, this.lastSeen, this.gender, {super.key});

  @override
  State<PersonWidget> createState() => PersonWidgetState();
}

class PersonWidgetState extends State<PersonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(Object context) {
    String lastSeenDisplayVal = Consts.notReportedYet(widget.gender);
    if (widget.lastSeen! > 0) {
      DateTime now = DateTime.now();
      DateTime lastTime = DateTime.fromMillisecondsSinceEpoch(widget.lastSeen!);
      int deltaInMinutes = now.difference(lastTime).inMinutes;
      lastSeenDisplayVal = Consts.xMinutesAgo(deltaInMinutes);
    }
    return Container(
        height: 50.0,
        margin: const EdgeInsetsDirectional.only(top: 1),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            border: Border.all(color: Colors.black)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(width: 10),
          Text(widget.name, textScaleFactor: 2),
          const Spacer(flex: 1),
          Text(
            lastSeenDisplayVal,
            textScaleFactor: 2,
          )
        ]));
  }
}
