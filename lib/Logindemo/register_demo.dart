import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_demo.dart';

class RegisterDemo extends StatefulWidget {
  const RegisterDemo({super.key});

  @override
  State<RegisterDemo> createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  final _tcEmail = TextEditingController();
  final _tcPassword = TextEditingController();

  Future<void> register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _tcEmail.text, password: _tcPassword.text);
          var data = {'email':  _tcEmail.text, 'password':  _tcPassword.text, 'role': 0};
          FirebaseFirestore.instance.collection('users').add(data).then(
            (value) => print('Adding done!'),
            onError: (e) => print('Error $e'),
          );
      // register OK
      // navigate back to login
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginDemo()),
          ((route) => false),
        );
      }
    } on FirebaseAuthException catch (e) {
      // register failed
      debugPrint('Error: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              onPressed: register,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
