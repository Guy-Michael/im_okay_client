import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllKinAccountedForCaption extends StatelessWidget {
  const AllKinAccountedForCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          SizedBox(
            width: 325,
            child: Text(
              'כל הקרובים עדכנו במצבם',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(width: 28, height: 28, child: Stack()),
        ],
      ),
    );
  }
}
