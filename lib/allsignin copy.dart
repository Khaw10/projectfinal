import 'package:flutter_application_4/student/Home_st.dart';
import 'package:flutter_application_4/teacher/thome.dart';

import 'package:flutter_application_4/taccount.dart';
// import 'thome.dart';
import 'package:flutter/material.dart';


class Allsignin2 extends StatefulWidget {
  const Allsignin2({super.key});

  @override
  State<Allsignin2> createState() => _Allsignin2State();
}

class _Allsignin2State extends State<Allsignin2> {
  
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    final TextField _txtUserName = new TextField(
      controller: nameController,
      decoration: new InputDecoration(
          hintText: 'Username',
          contentPadding: new EdgeInsets.all(10),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
      autocorrect: false,
    );

    final TextField _txtPassword = new TextField(
      controller: passwordController,
      decoration: new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.all(10),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
    );

    return Scaffold(
      backgroundColor: Color(0xFF8d0c02),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Container(
                height: 150,
                child: Image.network(
                    'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png'),
              ),
              const SizedBox(
                height: 2,
              ),
              const Center(
                child: Text('Appointment application',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 20,
              ),
             Column(
                children: <Widget>[
                  Container(
                    margin: new EdgeInsets.only(left: 20, right: 20),
                    decoration: new BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        border:
                            new Border.all(width: 1.2, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: _txtUserName,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                    margin: new EdgeInsets.only(left: 20, right: 20),
                    decoration: new BoxDecoration(
                        color: Color.fromARGB(255, 240, 240, 240),
                        border:
                            new Border.all(width: 1.2, color: Colors.black12),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: _txtPassword,
                  ),
              SizedBox(
                height: 30,
              ),
              
               Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () {
                        String? username = nameController.text;
                        
                        String? password = passwordController.text;
                        if (login(username, password) == 'student') {
                          print(login(username, password));
                         Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home_st(),
                        ),
                        (route) => false);
                        } else if (login(username, password) == 'teacher') {
                          print(login(username, password));
                          Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Thome(),
                        ),
                        (route) => false);
                        }
                        // Navigator.pushAndRemoveUntil(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) => const Thome(),
                        // ),
                        // (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 20,color: Color(0xFF8d0c02),fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

              const SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () { Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Taccount(),
                      ),
                      (route) => false);},
                child: const Text(
                  'Create your account ?',
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  var account = [
  {'username': 'student', 'password': '1234', 'role': 'student'},
  {'username': 'teacher', 'password': '4321', 'role': 'teacher'},
  ];
  String? login(String username, String password) {
    for (int i = 0; i < account.length; i++) {
      if (username == account[i]['username'] &&
          password == account[i]['password']) {
        return account[i]['role'];
      }
    }
    return null;
  }
  void login2() {
    String email = nameController.text;
    String password = passwordController.text;
    debugPrint(email);
    debugPrint(password);
  } 
}
