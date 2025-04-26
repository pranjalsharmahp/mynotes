import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("Your Email is not verified"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              print(user);
              try {
                await user?.sendEmailVerification();
              } catch (e) {
                print(e);
              }

              print("Email sent");
            },
            child: Text("Send Email"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser?.reload();
            },
            child: Text("Verify Email"),
          ),
        ],
      ),
    );
  }
}
