import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/welcomedemo.dart';


class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _tcEmail = TextEditingController();
  final _tcPassword = TextEditingController();

  Future<void> login() async {
    String email = _tcEmail.text;
    String password = _tcPassword.text;
    // debugPrint(email);
    // debugPrint(password);

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // login OK
      // debugPrint('Login OK');
      // debugPrint(credential.user!.email);
      // jump to welcome page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeDemo()),
        );
      }
    } on FirebaseAuthException catch (e) {
      // login error
      debugPrint('Error: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _tcEmail,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _tcPassword,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
