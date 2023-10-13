import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:fluttertoast/fluttertoast.dart';

const localServerUrl = "http://localhost:5000/report";
const serverUrl = "http://20.217.28.18:5000/report";
const bool isProduction = bool.fromEnvironment('dart.vm.product');
late HubConnection hubConnection;

void main() async {
  runApp(const MyApp());
  await initHubConnection();
}

Future<void> initHubConnection() async {
  String url = isProduction ? serverUrl : localServerUrl;
  hubConnection = HubConnectionBuilder().withUrl(url).build();
  hubConnection.on("ReceiveMessage", onMessageReceived);
  await hubConnection.start();
  checkConnectionState();
}

void onMessageReceived(List<Object?>? list) {
  String user = list?[0] as String;
  String message = list?[1] as String;
  Fluttertoast.showToast(msg: "$user sent $message");
}

void checkConnectionState() {
  if (hubConnection.state != HubConnectionState.Connected) {
    Fluttertoast.showToast(msg: "NOT Connected :(");
    return;
  }
  Fluttertoast.showToast(msg: "Connected!");
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await hubConnection
                  .send("SendMessage", args: ["username", "test message"]);
              Fluttertoast.showToast(msg: "Sending message..");
            },
            child: const Text('send message'),
          ),
        ],
      ),
    );
  }
}
