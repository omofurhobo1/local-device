import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:login/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

class LocalStorage {
  storeToken(String token) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString("auth_token", jsonEncode(token));
  }

  logOut() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove("auth_token");
  }
}
