import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_task/home_screen.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => false);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Text("Sign Out"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("user")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .delete()
                    .then(
                      (value) => {
                        FirebaseAuth.instance.currentUser!.delete().then(
                              (value) => {
                                Navigator.popUntil(context, (route) => false),
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                ),
                              },
                            )
                      },
                    );
              },
              child: Text("Delete User"),
            ),
          ),
        ],
      ),
    );
  }
}
