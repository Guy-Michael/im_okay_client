import 'dart:core';

import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/kin%20management/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';

class EmptyKinPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String helpText;
  final String? actionText;
  final Future<void> Function()? action;

  const EmptyKinPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.helpText,
      this.actionText,
      this.action});

  @override
  State<StatefulWidget> createState() => _EmptyKinPageState();
}

class _EmptyKinPageState extends State<EmptyKinPage> {
  @override
  Widget build(BuildContext context) {
    Image image;

    List<Widget> list = [
      KinPageTitle(
        title: widget.title,
      ),
      Divider(
        thickness: 1,
      ),
      Text(widget.subtitle),
      Text(widget.helpText),
      Expanded(
          child:
              Image(height: 208, width: 208, image: AssetImage("Assets/Kin/kin_page_empty.png"))),
      if (widget.action != null && widget.actionText != null)
        ElevatedButton.icon(
            label: Text(widget.actionText!),
            onPressed: widget.action,
            icon: Icon(Icons.add_circle, color: Colors.teal),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Color.fromARGB(0, 0, 0, 0)),
                shadowColor: WidgetStateProperty.all(Color.fromARGB(0, 0, 0, 0)))),
      Spacer()
    ];

    return Scaffold(
      appBar: AppBar(title: Text(KinPageBaseConsts.backButtonCaption)),
      body: Column(
        spacing: 12,
        children: list,
      ),
    );
  }
}
