import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/newlogin/login.dart';
import 'package:flutter_application_4/newlogin/profileCheck.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:ui/project/loginProject.dart';
// import 'package:ui/project/profileCheck.dart';

// import 'Forgot_Password_Verify.dart';

class Forgot_Password extends StatelessWidget {
  const Forgot_Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Forgot_Password_Page();
  }
}

class Forgot_Password_Page extends StatefulWidget {
  const Forgot_Password_Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Forgot_Password_Page> createState() => _Forgot_Password_PageState();
}

class _Forgot_Password_PageState extends State<Forgot_Password_Page> {
  TextEditingController ForgotemailController = TextEditingController();
  ProfileForgot profileForgot = ProfileForgot(EmailForgot: '');
  final _fromKey = GlobalKey<FormState>();
  final authEmail = FirebaseAuth.instance;

  Future<void> Forgot() async {
    if (_fromKey.currentState!.validate()) {
      try {
        await authEmail
            .sendPasswordResetEmail(
                email: ForgotemailController.text.trim().toString())
            .then((value) {
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => Login()));
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8d0c02),
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    //========================================================================
                    Row(
                      children: const [
                        Text(
                          'Verify Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: ForgotemailController,
                      cursorColor: const Color(0xFFd1b266),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFFd1b266)),
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFFd1b266))),
                        hintText: 'Email',
                      ),
                      onSaved: (ForgotemailController) {
                        profileForgot.EmailForgot = ForgotemailController!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              //========================================================================
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8d0c02),),
                  child: const Text('Verify Email'),
                  onPressed: Forgot,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

