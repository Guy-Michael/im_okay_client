import 'package:flutter/material.dart';
import 'package:im_okay_client/Widgets/my_text_field.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  AddFriendsPageState createState() => AddFriendsPageState();
}

class AddFriendsPageState extends State<AddFriendsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: MyTextField(
              inputController: searchController,
              hintText: 'חפשו חברים',
              icon: Icons.search,
            )),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return Pair(name: 'שמובי מיכאל כעעעעע');
            },
          ),
        ),
      ],
    ));
  }
}

class UserEntryWidget extends StatelessWidget {
  final String userName;

  const UserEntryWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(92, 155, 255, 255),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          userName,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          textScaleFactor: 2,
        ),
      ),
    );
  }
}

class Pair extends StatelessWidget {
  String name;

  Pair({this.name = '', super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffb4d3d7)),
                child: const Icon(Icons.add)),
            const SizedBox(
              width: 3,
            ),
            Container(
              alignment: Alignment.center,
              width: 160,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffb4d3d7)),
              child: Text(name,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ],
        ));
  }
}
