import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'Models/user.dart';
import 'Models/user.dart';
import 'Utils/http_utils.dart';
import 'package:im_okay_client/pages/login_page.dart';

void main() async {
  runApp(const MyApp());
  HttpUtils.reportOkay();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
