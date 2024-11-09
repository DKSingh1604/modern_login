// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modern_login/components/my_button.dart';
import 'package:modern_login/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //wrong email messsage popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Wrong Email"),
        );
      },
    );
  }

  //wrong password messsage popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Wrong Password"),
        );
      },
    );
  }

  //sign user in
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Lottie.asset(
            'lib/animations/loading.json',
            width: 150,
            height: 150,
          ),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop loading animation
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading animation
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
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

                //email textfield
                MyTextfield(
                  controller: emailController,
                  // hintText: "Username",
                  obscureText: false,
                  labelText: "Email",
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
                MyButton(
                  onTap: signUserIn,
                ),

                SizedBox(
                  height: 23,
                ),

                //or continue text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          indent: 20,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 35,
                ),

                //google + apple logins

                //google button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'lib/images/google1.webp',
                        height: 67,
                      ),
                    ),

                    SizedBox(
                      width: 25,
                    ),

                    //apple button
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset(
                            'lib/images/apple1.png',
                            height: 67,
                            width: 67,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 35,
                ),
                //not a member? sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      "Regsiter here",
                      style: TextStyle(color: Colors.blue, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
