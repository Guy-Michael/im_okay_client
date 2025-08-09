import 'package:flutter/material.dart';
import 'package:im_okay/Models/app_user.dart';
import 'package:im_okay/pages/kin/kin%20requests/kin_requests_page.dart';

class PendingKinRequest extends StatefulWidget {
  final AppUser user;

  const PendingKinRequest({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => PendingKinRequestState();
}

class PendingKinRequestState extends State<PendingKinRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 361,
        height: 120,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage("https://picsum.photos/200/200"))),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.user.fullName,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Row(
                spacing: 16,
                children: [
                  getPendingKinRequestButton(
                      color: Colors.teal,
                      onPressed: () {},
                      caption: KinRequestConsts.approveButtonCaption),
                  getPendingKinRequestButton(
                      color: Color.fromARGB(1, 232, 232, 232),
                      onPressed: () {},
                      caption: KinRequestConsts.denyButtonCaption,
                      textColor: Colors.black)
                ],
              )
            ]),
          ],
        ));
  }

  ElevatedButton getPendingKinRequestButton(
      {required Color color,
      required Function() onPressed,
      required String caption,
      Color textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color, minimumSize: Size(112, 35), maximumSize: Size(224, 70)),
      child: Text(
        caption,
        style: TextStyle(color: textColor, fontSize: 18),
      ),
    );
  }
}
