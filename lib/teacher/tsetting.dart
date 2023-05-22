import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/newlogin/login.dart';

import 'tbar.dart';
import 'package:flutter/material.dart';

class Tsetting extends StatefulWidget {
  const Tsetting({super.key});

  @override
  State<Tsetting> createState() => _TsettingState();
}

class _TsettingState extends State<Tsetting> {
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
        backgroundColor: Color(0xFF8d0c02),
        title: Text('Setting'),
      ),
      drawer: Tbar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            ListTile(
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
          ],
        ),
      ),
    );
  }
}
