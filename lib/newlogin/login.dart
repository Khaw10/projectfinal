import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/adminpage.dart';
import 'package:flutter_application_4/newlogin/ForgotPassword.dart';
import 'package:flutter_application_4/newlogin/Singnin.dart';
import 'package:flutter_application_4/not/undetifi.dart';
import 'package:flutter_application_4/student/Home_st.dart';
import 'package:flutter_application_4/teacher/thome.dart';

class Login extends StatelessWidget {
  Login({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginPage(
        nameController: nameController, passwordController: passwordController);
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.nameController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController passwordController;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromKey = GlobalKey<FormState>();
  String role = 'not registered';
  final user = FirebaseAuth.instance.currentUser;
  Future<void> login() async {
    String email = widget.nameController.text;
    String password = widget.passwordController.text;

    try {
      if (_fromKey.currentState!.validate()) {
        ScaffoldMessenger.of(context);

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        // login OK
        debugPrint('Login OK');
        // jump to welcome page
        if (mounted) {
          var query = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();
          var docs = query.docs;
          if (docs.isNotEmpty) {
            if (docs[0]['role'] == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Adminpage(),
                  settings: RouteSettings(arguments: email),
                ),
              );
            } else if (docs[0]['role'] == 'student') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home_st(),
                  settings: RouteSettings(arguments: email),
                ),
              );
            } else if (docs[0]['role'] == 'teacher') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Thome(),
                  settings: RouteSettings(arguments: email),
                ),
              );
            } else if (docs[0]['role'] == 'not registered') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => dontkonw2(),
                  settings: RouteSettings(arguments: email),
                ),
              );
            }
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      // login error
      debugPrint('Error: ${e.code}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF8d0c02),
        body: SafeArea(
          child: Form(
            key: _fromKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  const Image(
                      width: 150,
                      height: 150,
                      image: NetworkImage(
                          'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png')),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Appointment Application',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: widget.nameController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIconColor: const Color(0xFFd1b266),
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
                      // labelText: 'User Name',
                      // labelStyle: TextStyle(color: Color(0xFF30eb4b),fontWeight: FontWeight.bold)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: widget.passwordController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Color(0xFFd1b266),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forgot_Password()));
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFd1b266)),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: login,
                        // if (_fromKey.currentState!.validate()) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(const SnackBar(
                        //     content: Text('Login Success'),
                        //   ));
                        // }
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Does not have your account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        child: const Text(
                          'Sign in',
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFFd1b266)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
