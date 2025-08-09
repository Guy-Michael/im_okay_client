import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';

class AddKinPage extends StatefulWidget {
  const AddKinPage({super.key});

  @override
  State<StatefulWidget> createState() => AddKinPageState();
}

class AddKinPageState extends State<AddKinPage> {
  @override
  Widget build(BuildContext context) {
    AppUser user = AppUser(firstName: "טל", lastName: "כספי");
    AppUser user2 = AppUser(firstName: "נועם", lastName: "נחום");
    AppUser user3 = AppUser(firstName: "בן", lastName: "קאושנסקי");
    AppUser user4 = AppUser(firstName: "זיו", lastName: "קידר");
    return Scaffold(
        body: Column(
      children: [
        Kin(
          user: user,
        ),
        Kin(
          user: user2,
        ),
        Kin(
          user: user3,
        ),
        Kin(
          user: user4,
        ),
      ],
    ));
  }
}

class Kin extends StatefulWidget {
  final AppUser user;

  const Kin({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => KinState();
}

class KinState extends State<Kin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          border: Border.all(color: Colors.black),
          gradient: LinearGradient(colors: [Colors.white, Colors.grey]),
          backgroundBlendMode: BlendMode.color,
        ),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Text("Image"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.user.fullName), Text("Phone")],
                ),
                Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, minimumSize: Size(112, 35)),
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )));
  }
}
