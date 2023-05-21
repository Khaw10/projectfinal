import '../taccount.dart';
import '../teacher/thome.dart';
import 'package:flutter/material.dart';

class Tsignin extends StatefulWidget {
  const Tsignin({super.key});

  @override
  State<Tsignin> createState() => _TsigninState();
}

class _TsigninState extends State<Tsignin> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextField _txtUserName = new TextField(
      decoration: new InputDecoration(
          hintText: 'Username',
          contentPadding: new EdgeInsets.all(10),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
      autocorrect: false,
    );

    final TextField _txtPassword = new TextField(
      decoration: new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.all(10),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
      autocorrect: false,
      obscureText: true,
    );

    return Scaffold(
      backgroundColor: Colors.red,
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
                        Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Thome(),
                      ),
                      (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 15.0,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
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
}
