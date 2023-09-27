import 'package:flutter/material.dart';
import 'package:flutterrestapimysql/pages/hello.dart';
import 'package:flutterrestapimysql/pages/home.dart';
import 'package:flutterrestapimysql/pages/login.dart';
import 'package:flutterrestapimysql/pages/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/hello': (context) => const Hello(),
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
      },
      title: 'Flutter REST API MySQL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
