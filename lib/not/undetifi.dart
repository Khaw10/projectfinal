import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../newlogin/login.dart';
class dontkonw2 extends StatelessWidget {
  const dontkonw2({super.key});
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // sign out successfully
      // navigate back to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      // cannot sign out
      debugPrint('Erro: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รอแอดมินลงทะเบียน'),
        backgroundColor: Color(0xFF8d0c02),
      ),
      body: ListTile(
              onTap: () {
                logout(context);
              },
              leading: Icon(Icons.logout_sharp,color: Colors.black,size: 30,),
              title: const Text(
                'Sign out',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}