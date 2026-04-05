import 'dart:core';

import 'package:flutter/material.dart';
import 'package:im_okay/pages/kin/KinManagement/components/kin_page_title.dart';
import 'package:im_okay/pages/kin/kin%20page%20base/kin_page_base.dart';
import 'package:im_okay/pages/SharedComponents/go_to_add_kin_page_button.dart';

class EmptyKinPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String helpText;
  final bool showAddKinButton;

  const EmptyKinPage(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.helpText,
      this.showAddKinButton = false});

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
      if (widget.showAddKinButton) GoToAddKinPageButton(),
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
