// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:modern_login/components/my_button.dart';
import 'package:modern_login/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),

              //logo
              Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(
                height: 70,
              ),

              //welcome back, you have been missed
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                  color: Colors.grey[700],
                  // fontSize: 15,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //username textfield
              MyTextfield(
                controller: usernameController,
                // hintText: "Username",
                obscureText: false,
                labelText: "Username",
              ),

              //pasword textfield
              MyTextfield(
                controller: passwordController,
                // hintText: "Password",
                obscureText: true,
                labelText: "Password",
              ),

              //forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),

              //sign in button
              MyButton(),

              //or continue text

              //google + apple logins

              //not a member? sign up text
            ],
          ),
        ),
      ),
    );
  }
}
