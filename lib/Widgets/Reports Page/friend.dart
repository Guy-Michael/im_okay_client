import 'package:flutter/material.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class FriendReport extends StatefulWidget {
  final String name;
  final int lastSeen;
  final String gender;

  const FriendReport(
      {super.key,
      this.name = '',
      this.lastSeen = 0,
      this.gender = Gender.female});

  @override
  State<FriendReport> createState() => _FriendReportState();
}

class _FriendReportState extends State<FriendReport> {
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
  debugPrint(duration.toString());
  if (duration.inHours < 1) {
    result = Consts.xMinutesAgo(duration.inMinutes);

    // result = DateTime.fromMillisecondsSinceEpoch(lastSeen).toString();
    // result = '${DateTime(lastSeen).hour}:${DateTime(lastSeen).minute}';
    // result = intl.DateFormat.().format(DateTime(lastSeen),);
  } else {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(lastSeen);
    result = " ${time.day}.${time.month}, ${time.hour}:${time.minute}";
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
