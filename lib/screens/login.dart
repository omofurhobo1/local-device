import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:login/Screens/SignIn.dart';
import 'package:login/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  loginUserRequest() async {
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    final response =
        await http.post(Uri.parse("https://reqres.in/api/login"), body: data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      LocalStorage().storeToken(data["token"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://docs.flutter.dev/assets/images/dash/BigDashAndLittleDash.png")),
                ), //container
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: ('Email'),
                  hintText: ('Enter your E-mail'),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ('Password'),
                  hintText: ('Enter your password'),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20.0),
              const Row1(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    maximumSize: Size(MediaQuery.of(context).size.width, 50),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignIn();
                  }));
                },
                child: const Text('Sign in'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class Row1 extends StatelessWidget {
  const Row1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text("Remember me"),
          Text("Forget password"),
        ]);
  }
}
