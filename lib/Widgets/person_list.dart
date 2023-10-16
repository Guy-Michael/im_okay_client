import 'package:flutter/material.dart';
import 'package:im_okay_client/Models/user.dart';

class PersonList extends StatelessWidget {
  final List<User> users;
  const PersonList(this.users, {super.key});

  List<PersonWidget> generatePersonList() {
    return users.map((User u) {
      return PersonWidget(u.nameHeb, u.lastSeen);
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
  final int? lastSeen;

  const PersonWidget(this.name, this.lastSeen, {super.key});

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
    String lastSeenDisplayVal = '0';
    // lastSeenDisplayVal = widget.lastSeen!.toString();
    if (widget.lastSeen! > -1) {
      DateTime now = DateTime.now();
      DateTime lastSeenTime =
          DateTime.fromMillisecondsSinceEpoch(widget.lastSeen!);
      int deltaInMinutes = now.difference(lastSeenTime).inSeconds;
      lastSeenDisplayVal = deltaInMinutes.toString();
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
            '$lastSeenDisplayVal seconds ago',
            textScaleFactor: 2,
          )
        ]));
  }
}
