import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'tbar.dart';
import 'package:flutter/material.dart';

class Thome extends StatefulWidget {
  const Thome({super.key});

  @override
  State<Thome> createState() => _ThomeState();
}

class _ThomeState extends State<Thome> {
  TextEditingController anotc = TextEditingController();
  String? uid;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      final status = [];
    });
    var ans;
    final status = [];
    final user = FirebaseAuth.instance.currentUser;
    final _userStream = FirebaseFirestore.instance
        .collection('bookings')
        .where(
          "temail",
          isEqualTo: email,
        )
        .where(
          "status",
          isEqualTo: 'Pending',
        )
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
          var data = snapshot.data!.docs;

          // show data in ListView
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF8d0c02),
                title: Text('Home'),
                // actions: [
                //   IconButton(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Thome(),
                //           settings: RouteSettings(arguments: email),
                //         ),
                //       );
                //     },
                //     icon: Icon(Icons.refresh),
                //   ),
                // ],
              ),
              drawer: Tbar(),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 45, right: 45),
                              child: Container(
                                width: 100,
                                height: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF1f222b)),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${data[index]['simage']}'),
                                          radius: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('${data[index]['sname']}'),
                                            Row(
                                              children: [
                                                Text('Status:',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                Text('${data[index]['status']}',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFd1b266))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
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
                                              Text(
                                                  ' Date: ${data[index]['date']}'),
                                              Text(
                                                  'Time: ${data[index]['ftime']}.00 - ${data[index]['ltime']}.00'),
                                              Text(
                                                  'Location: ${data[index]['note']}'),
                                              Text(
                                                  'Status : ${data[index]['status']}'),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                // controller: _tcName,
                                                controller: anotc,
                                                decoration: InputDecoration(),
                                              ),
                                              if (ans != null) Text(ans)
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Approve');
                                                  },
                                                  child: const Text(
                                                    'Approve',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 42, 72, 181)),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Disapproved');
                                                  },
                                                  child: const Text(
                                                    'Disapproved',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 196, 18, 5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (answer == 'Approve') {
                                      var up = {
                                        'status': 'Approve',
                                      };
                                      FirebaseFirestore.instance
                                          .collection('bookings')
                                          .doc(data[index].id)
                                          .update(up)
                                          .then(
                                            (value) =>
                                                print('Document update!'),
                                            onError: (e) => print('Error $e'),
                                          );
                                    }
                                    if (answer == 'Disapproved') {
                                      var up = {
                                        'status': 'Disapproved',
                                        'annotation': anotc.text,
                                      };
                                      FirebaseFirestore.instance
                                          .collection('bookings')
                                          .doc(data[index].id)
                                          .update(up)
                                          .then(
                                            (value) =>
                                                print('Document update!'),
                                            onError: (e) => print('Error $e'),
                                          );
                                    }
                                  },
                                ),
                              ),
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
