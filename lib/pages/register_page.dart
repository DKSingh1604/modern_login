// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modern_login/components/my_button.dart';
import 'package:modern_login/components/my_textfield.dart';
import 'package:modern_login/pages/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //wrong email messsage popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          title: Text(
            "Wrong Email",
            style: TextStyle(fontSize: 18),
          ),
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
          elevation: 5,
          title: Text(
            "Wrong Password",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  //email field empty function
  void noEmail() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Email field can't be empty",
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  //password field empty function
  void noPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[200],
          title: Text(
            "Password field can't be empty",
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }

  //S I G N     U S E R    U P    F U N C T I O N
  void signUserUp() async {
    if (emailController.text.isEmpty) {
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
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pop(context);

      noEmail();
      return;
    }

    if (passwordController.text.isEmpty) {
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
      await Future.delayed(Duration(milliseconds: 500));

      Navigator.pop(context);
      noPassword();
      return;
    }

    // show loading animation
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
    //delay for 1 second
    await Future.delayed(Duration(seconds: 1));

    //try creating the user
    try {
      //check if password and confrim password are the same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else if (passwordController.text.length < 6 ||
          confirmPasswordController.text.length < 6) {
        //pop loading animation
        Navigator.pop(context);

        //show passwordLength dialogbox
      } else {
        //pop loading animation
        Navigator.pop(context);

        //show error dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: Text(
                "Passwords do not match",
                style: TextStyle(fontSize: 18),
              ),
            );
          },
        );
      }
      //pop loading animation - if sign up successfull
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading animation
      Navigator.pop(context);

      //show error box
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'invalid-credential') {
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
                  height: 40,
                ),

                //welcome message
                Text(
                  "We Welcome you!",
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

                //confirm pasword textfield
                MyTextfield(
                  controller: confirmPasswordController,
                  // hintText: "Password",
                  obscureText: true,
                  labelText: "Confirm Password",
                ),

                SizedBox(
                  height: 15,
                ),

                //sign up button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign Up",
                ),

                SizedBox(
                  height: 15,
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
                  height: 30,
                ),

                //google + apple logins

                //google button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AuthService().signInWithGoogle(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'lib/images/google1.webp',
                          height: 67,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 25,
                    ),

                    //apple button
                    GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
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
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                //not a member? sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login here",
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
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
