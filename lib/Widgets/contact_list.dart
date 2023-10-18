import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scrollable(
            axisDirection: AxisDirection.down,
            viewportBuilder: (context, position) =>
                FutureBuilder<List<Contact>>(
                    future: getContactList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: order(snapshot.data!));
                      }
                      return const CircularProgressIndicator();
                    })));
  }
}

List<Text> order(List<Contact> list) {
  List<Text> texts = [];
  for (var element in list) {
    if (element.phones.isNotEmpty) {
      texts.add(Text(
        '${element.displayName} - ${element.phones[0].number}',
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(
            color: Colors.black, backgroundColor: Colors.red, fontSize: 15),
      ));
    }
  }

  return texts;
}

Future<List<Contact>> getContactList() async {
  if (await FlutterContacts.requestPermission()) {
    List<Contact> contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: false);
    return contacts;
  }

  return [];
}
