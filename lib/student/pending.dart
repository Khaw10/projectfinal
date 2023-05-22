import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'package:flutter/material.dart';

class Pending extends StatefulWidget {
  static const routeName = '/pending';

  const Pending({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PendingState();
  }
}

class _PendingState extends State<Pending> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? uid;
  TextEditingController anotc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    final user = FirebaseAuth.instance.currentUser;
    final _userStream = FirebaseFirestore.instance
        .collection('bookings')
        .where("semail", isEqualTo: email)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          // connection error?
          if (snapshot.hasError) {
            return const Text('Connection error');
          }
          // connecting?
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading data...');
          }
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User is currently signed out!');
            } else {
              print('User is signed in!');
              uid = user.uid;
            }
          });

          // updateUI();
          print(email);
          print(uid);

          // data ready
          var data = snapshot.data!.docs;

          // show data in ListView
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF8d0c02),
                title: Text('Status'),
              ),
              drawer: Home(),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 45, right: 45),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF1f222b)),
                                    child: Row(
                                      children: [
                                        Text('${data[index]['date']}'),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text('${data[index]['status']}',
                                            style: TextStyle(
                                                color: Color(0xFFd1b266))),
                                      ],
                                    ),
                                    onPressed: () async {
                                      String? answer = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          //=========================================================
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      '${data[index]['timage']}'),
                                                  radius: 40,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    'Date: ${data[index]['date']}'),
                                                Text(
                                                    'Time: ${data[index]['ftime']}.00 - ${data[index]['ltime']}.00'),
                                                Text(
                                                    'Locations: ${data[index]['note']}'),
                                                Text(
                                                    'Status: ${data[index]['status']}'),
                                                Text(
                                                    '${data[index]['annotation']}'),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // anotc.text = data[index]['annotation'],
                                                TextField(
                                                  controller: anotc,
                                                  decoration: InputDecoration(),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
