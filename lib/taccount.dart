import 'package:flutter_application_4/allsignin.dart';

import 'dontkonw/tsignin.dart';
import 'package:flutter/material.dart';

class Taccount extends StatefulWidget {
  const Taccount({super.key});

  @override
  State<Taccount> createState() => _TaccountState();
}

class _TaccountState extends State<Taccount> {
   TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF8d0c02),
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: const Text(
                'Create your account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),

          const Center(
            child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.yellow,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png'),
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                makeInput(label: "Name"),
                makeInput(label: "Username"),
                makeInput(label: "User ID"),
                makeInput(label: "Email"),
                makeInput(label: "Password", obsureText: true)
              ],
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
              child: ElevatedButton(
                child: const Text('Sign In'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Allsignin(),
                      ),
                      (route) => false);
                  print(nameController.text);
                  print(passwordController.text);
                  
                },style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
              )),
        ],
      ),
    ));
  }
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 1,
      ),
      TextField(
        obscureText: obsureText,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
