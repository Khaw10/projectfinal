import 'package:flutter/material.dart';
import 'package:flutter_application_4/student/home.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8d0c02),
        title: Text('Contact'),
      ),
      drawer: Home(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              height: 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 50,
                              color: Colors.black,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    'ส่วนทะเบียน อาคารบริหารวิชาการAS \nห้อง 107-1-8-333/1 ต.ท่าสุด อ.เมือง',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\n จ.เชียงราย 57100 ',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0),
                        child: Container(
                          height: 200,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 50,
                                color: Colors.black,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '0123456789\n',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  children: [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
