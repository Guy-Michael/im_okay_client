import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Models/user.dart';

const localDomain = "http://localhost";
const localPort = "5129";
const serverDomain = "http://20.217.28.18";
const serverPort = "5000";
const hubRoute = "report";
const bool isProduction = bool.fromEnvironment('dart.vm.product');

User? connectedUser;
HubConnection? hubConnection;

void main() async {
  runApp(const MyApp());
  await initHubConnection();
}

Future<void> initHubConnection() async {
  String url = isProduction ? serverDomain : localDomain;
  String port = isProduction ? serverPort : localPort;
  url += ":$port/$hubRoute";

  hubConnection = HubConnectionBuilder().withUrl(url).build();
  hubConnection?.on("ReceiveOkayStatus", onOkayStatusReceived);
  hubConnection?.on("DenyAccess", denyAccess);
  hubConnection?.on("GetUserData", getUserData);
  await hubConnection?.start();
  checkConnectionState();
}

void onLoginAttempt(String username, String password) async {
  String accessToken = User.generateAccessToken(username, password);
  await hubConnection?.send("Login", args: [accessToken]);
}

void onOkayStatusReceived(List<Object?>? list) {
  User user = list?[0] as User;
  Fluttertoast.showToast(msg: "$user בסדר!", toastLength: Toast.LENGTH_LONG);
}

void getUserData(List<Object?>? users) {
  String? connectedUserJson = users?[0].toString();
  connectedUser = User.fromJson(jsonDecode((connectedUserJson!)));
  print("user:" + connectedUserJson);
  Fluttertoast.showToast(msg: "$connectedUser is connected!");
}

void denyAccess(List<Object?>? parameters) {
  Fluttertoast.showToast(msg: "Not logged in.");
}

void checkConnectionState() {
  if (hubConnection?.state != HubConnectionState.Connected) {
    Fluttertoast.showToast(msg: "NOT Connected :(");
    return;
  }
  Fluttertoast.showToast(msg: "Connected!");
}

Future<T?> makeRequestToHub<T>(String methodName, List<Object>? argList) async {
  try {
    T result = await hubConnection?.invoke(methodName, args: argList) as T;
    return result;
  } catch (error) {
    Fluttertoast.showToast(msg: "failed to invoke $methodName");
    return null;
  }
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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String username = usernameController.text;
              String password = passwordController.text;
              onLoginAttempt(username, password);
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (connectedUser == null) {
                Fluttertoast.showToast(msg: "Not logged in.");
                return;
              }

              await makeRequestToHub("MarkAsOkay", [connectedUser!]);
              Fluttertoast.showToast(msg: "מסמן כבסדר..");
            },
            child: const Text('send message'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginState();
}
