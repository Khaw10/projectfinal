import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import '../dontkonw/home1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/student/home.dart';

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
          // void updateUI() {

          //     FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //       if (user == null) {
          //         print('User is currently signed out!');
          //       } else {
          //         print('User is signed in!');
          //         // setState(() {
          //         // uid = user.uid;
          //         // });
          //       }
          //     });

          // }
          // updateUI();
          print(email);
          print(uid);

          // data ready

          // convert data to List
          // var status = [];
          // // print(status);
          // // List<Map<dynamic,dynamic>> status;
          // var userimage;
          // var username;
          // var useremail;
          // var userid;

          var data = snapshot.data!.docs;
          // for (var i = 0; i < data.length; i++) {
          //   // if (data[i]['student'] == uid) {
          //     // username = data[i]['name'];
          //     // useremail = data[i]['email'];
          //     // userid = data[i]['id'];
          //     // userimage = data[i]['image'];
          //     var ans = {
          //       'teacher': data[i]['teacher'],
          //       'temail': data[i]['temail'],
          //       'timage': data[i]['timage'],
          //       'sname': data[i]['sname'],
          //       'student': data[i]['student'],
          //       'simage': data[i]['simage'],
          //       'note': data[i]['note'],
          //       'date': data[i]['date'],
          //       'ftime': data[i]['ftime'],
          //       'ltime': data[i]['ltime'],
          //       'ftimeStamp': data[i]['ftimeStamp'],
          //       'ltimeStamp': data[i]['ltimeStamp'],
          //       'status': data[i]['status'],
          //     };
          //     status.add(ans);
          //   // }
          // }
          // print(status);
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
                                                Text('Date: ${data[index]['date']}'),
                                                Text(
                                                    'Time: ${data[index]['ftime']}.00 - ${data[index]['ltime']}.00'),
                                                Text('Note: ${data[index]['note']}'),
                                                Text(
                                                    'Status: ${data[index]['status']}'),
                                                Text('${data[index]['annotation']}'),
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
                                            // actions: [
                                            //   Row(
                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                            //     children: [
                                            //       TextButton(
                                            //         onPressed: () {
                                            //           Navigator.of(context).pop('Approve');
                                            //         },
                                            //         child: const Text('Approve'),
                                            //       ),
                                            //       TextButton(
                                            //         onPressed: () {
                                            //           Navigator.of(context).pop('Disapproved');
                                            //         },
                                            //         child: const Text(
                                            //           'Disapproved',
                                            //           style: TextStyle(color: Colors.red),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ],
                                          );
                                        },
                                      );

                                      // if (answer == 'Approve') {
                                      //   // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
                                      //   //       (value) => print('Document deleted!'),
                                      //   //       onError: (e) => print('Error $e'),
                                      //   //     );
                                      // }
                                      // if (answer == 'Disapproved') {
                                      //   // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
                                      //   //       (value) => print('Document deleted!'),
                                      //   //       onError: (e) => print('Error $e'),
                                      //   //     );
                                      // }
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
