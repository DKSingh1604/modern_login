// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  //sign user out
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Logged In as: ${user.email!}",
          style: TextStyle(fontSize: 20),
        ),
        // child: Lottie.asset('lib/animations/loading.json',
        //     width: 200, height: 200),
      ),
    );
  }
}
