import 'package:flutter/material.dart';

class KinPageTitle extends StatefulWidget {
  final String title;

  const KinPageTitle({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => KinPageTitleState();
}

class KinPageTitleState extends State<KinPageTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        alignment: Alignment.centerRight,
        child: Text(
          widget.title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
