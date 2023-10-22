import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:im_okay_client/Utils/Consts/consts.dart';

class Friend extends StatefulWidget {
  final String name;
  final int lastSeen;
  final String gender;

  const Friend(
      {super.key,
      this.name = '',
      this.lastSeen = 0,
      this.gender = Gender.female});

  @override
  State<Friend> createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 1,
        textDirection: TextDirection.rtl,
        alignment: WrapAlignment.start,
        children: [
          Container(
              constraints: nameBoxConstraints,
              alignment: Alignment.center,
              decoration: boxDecoration,
              child: Text(widget.name, style: textStyle)),
          Container(
              constraints: lastSeenBoxConstraints,
              alignment: Alignment.center,
              decoration: boxDecoration,
              child: Text(parseLastSeen(widget.lastSeen, widget.gender),
                  style: textStyle))
        ]);
  }
}

String parseLastSeen(int lastSeen, String gender) {
  String result = '';

  if (lastSeen == 0) {
    return Consts.notReportedYet(gender);
  }

  int delta = DateTime.now().millisecondsSinceEpoch - lastSeen;
  Duration duration = Duration(milliseconds: delta);

  if (duration.inHours > 1) {
    result = intl.DateFormat.Hm().format(DateTime.now());
  } else {
    result = Consts.xMinutesAgo(duration.inMinutes);
  }

  return result;
}

const BoxConstraints nameBoxConstraints =
    BoxConstraints(maxWidth: 120, maxHeight: 40, minWidth: 60, minHeight: 20);

const BoxConstraints lastSeenBoxConstraints =
    BoxConstraints(maxWidth: 120, maxHeight: 40, minWidth: 60, minHeight: 20);

const TextStyle textStyle =
    TextStyle(fontSize: 15, fontWeight: FontWeight.w700);

BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: const Color(0xffb4d3d7));