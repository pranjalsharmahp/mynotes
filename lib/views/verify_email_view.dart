import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
      body: Center(
        child: Column(
          children: [
            Text("Your Email is not verified"),
            TextButton(
              onPressed: () async {
                if (!context.mounted) return;
                try {
                  await AuthService.firebase().sendEmailVerification();
                } catch (e) {
                  devtools.log(e.toString());
                }

                devtools.log("Verification email sent");
              },
              child: Text("Send Email"),
            ),
            TextButton(
              onPressed: () async {
                AuthService.firebase().reloadUser();
                final user = AuthService.firebase().currentUser;

                if (user?.isEmailVerified ?? false) {
                  if (!context.mounted) return;
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  devtools.log("Email not verified");
                }
              },
              child: Text("Verify Email"),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                if (!context.mounted) return;
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: Text("Edit Email and Password"),
            ),
          ],
        ),
      ),
    );
  }
}
