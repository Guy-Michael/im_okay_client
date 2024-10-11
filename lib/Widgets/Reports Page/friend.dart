import 'package:flutter/material.dart';
import 'package:im_okay/Utils/Consts/consts.dart';

class FriendReport extends StatefulWidget {
  final String name;
  final int lastSeen;
  final String gender;

  const FriendReport({super.key, this.name = '', this.lastSeen = 0, this.gender = Gender.female});

  @override
  State<FriendReport> createState() => _FriendReportState();
}

class _FriendReportState extends State<FriendReport> {
  @override
  Widget build(BuildContext context) {
    return Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: getList(widget.name, widget.lastSeen, widget.gender));
  }
}

List<Widget> getList2() {
  return [
    Expanded(
        child: Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: Text(
          'Container 1',
          style: TextStyle(color: Colors.white),
        ),
      ),
    )),
    Expanded(
        child: Container(
      color: Colors.green,
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: Text(
          'Container 2',
          style: TextStyle(color: Colors.white),
        ),
      ),
    )),
  ];
}

List<Widget> getList(String name, int lastSeen, String gender) {
  return [
    Expanded(
        child: Container(
            constraints: nameBoxConstraints,
            alignment: Alignment.center,
            decoration: boxDecoration,
            child: Text(name, style: textStyle))),
    const SizedBox(width: 1),
    Expanded(
        child: Container(
            constraints: lastSeenBoxConstraints,
            alignment: Alignment.center,
            decoration: boxDecoration,
            child: Text(parseLastSeen(lastSeen, gender), style: textStyle)))
  ];
}

String parseLastSeen(int lastSeen, String gender) {
  String result = '';

  if (lastSeen == 0) {
    return Consts.notReportedYet(gender);
  }

  int delta = DateTime.now().millisecondsSinceEpoch - lastSeen;
  Duration duration = Duration(milliseconds: delta);

  result = Consts.xTimeAgo(duration);

  return result;
}

const BoxConstraints nameBoxConstraints = BoxConstraints.expand(height: 40);
const BoxConstraints lastSeenBoxConstraints = BoxConstraints.expand(height: 40);
const TextStyle textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

BoxDecoration boxDecoration =
    BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xffb4d3d7));
