import 'package:flutter/material.dart';
import 'package:im_okay_client/Models/user.dart';
import 'package:im_okay_client/Utils/http_utils.dart';

class PersonList extends StatelessWidget {
  late Future<List<User>> futureUsers;

  PersonList({super.key}) {
    futureUsers = HttpUtils.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: futureUsers,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User>? users = snapshot.data;
          List<Person>? people =
              users?.map((User u) => Person(u.username)).toList();
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: people!);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class Person extends StatefulWidget {
  final String name;
  final String lastSeen = "0";

  Person(this.name, {super.key});

  // void setLastSeen(int lastTimeSeen) {
  //   lastSeen = Random().nextInt(10).toString();
  // }

  @override
  State<StatefulWidget> createState() => PersonState();
}

class PersonState extends State<Person> {
  PersonState();
  @override
  Widget build(Object context) {
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
            '${widget.lastSeen} minutes ago',
            textScaleFactor: 2,
          )
        ]));
  }
}
