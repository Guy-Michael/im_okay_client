import 'package:flutter/material.dart';

class ImOkayOverlay extends StatelessWidget {
  final Widget child;

  const ImOkayOverlay({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    debugPrint("overlayyy");
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          children: [Expanded(child: child)],
        ));
  }
}
