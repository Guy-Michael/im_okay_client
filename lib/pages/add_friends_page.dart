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
            padding: const EdgeInsets.all(16.0),
            child: MyTextField(
              inputController: searchController,
              hintText: 'חפשו חברים',
              icon: Icons.search,
            )),
        Expanded(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return UserEntryWidget(userName: 'משתמש ');
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
        color: const Color.fromARGB(
            92, 155, 255, 255), // Semi-transparent background
        border: Border.all(color: Colors.grey), // Weak border
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          userName,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          textScaleFactor: 2,
        ),
        // Add any additional widgets for user actions here
      ),
    );
  }
}
