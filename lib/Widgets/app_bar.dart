import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  final Widget child;

  const Base({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Column(
          children: [Expanded(child: child)],
        ));
  }
}
