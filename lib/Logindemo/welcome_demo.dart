import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_demo.dart';

class WelcomeDemo extends StatefulWidget {
  const WelcomeDemo({super.key});

  @override
  State<WelcomeDemo> createState() => _WelcomeDemoState();
}

class _WelcomeDemoState extends State<WelcomeDemo> {
  final user = FirebaseAuth.instance.currentUser;
  String role = 'not registered';

  //  --------------- log out ----------------
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // sign out successfully
      // navigate back to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginDemo()),
      );
    } on FirebaseAuthException catch (e) {
      // cannot sign out
      debugPrint('Erro: ${e.code}');
    }
  }

  //  --------------- get user's role ----------------
  Future<void> getRole() async {
    var query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .get();
    var docs = query.docs;
    // print(docs.length);
    // print(docs[0]['role']);
    if (docs.isNotEmpty) {
      if (docs[0]['role'] == 1) {
        setState(() {
          role = 'admin';
        });
      }
      else if (docs[0]['role'] == 2) {
        setState(() {
          role = 'student';
        });
      }
      else if (docs[0]['role'] == 3) {
        setState(() {
          role = 'teacher';
        });
      }
    }
  }

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            user == null
                ? const Text('Waiting...')
                : Text('Welcome ${user!.email}'),
            Text('Role: $role'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
