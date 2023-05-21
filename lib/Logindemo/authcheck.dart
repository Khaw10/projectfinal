import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_demo.dart';
import 'welcome_demo.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            // already signed in
            return WelcomeDemo();
          } else {
            // not yet signed in
            return const LoginDemo();
          }
        }),
      ),
    );
  }
}
