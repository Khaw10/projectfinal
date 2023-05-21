import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/adminbar.dart';
import 'package:flutter_application_4/newlogin/login.dart';
import 'package:flutter_application_4/teacher/tbar.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  String? uid;
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
    var email = ModalRoute.of(context)!.settings.arguments as String;
    
    final user = FirebaseAuth.instance.currentUser;
    final _userStream = FirebaseFirestore.instance
        .collection('users')
        // .where("role", isEqualTo: 0)
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
          // for (var i = 0; i < data.length; i++) {
          //   if (data[i]['role'] == 0) {
              
          //     // urole = 'not registered';
          //   }
          // }
          String urole;
          // String? getrole(var data){
          //   for (var i = 0; i < data.length; i++) {
          //    if (data[i]['role'] == 1) {
          //     return 'admin';
          //   }else if (data[i]['role'] == 2) {
          //     return 'student';
          //   }else if (data[i]['role'] == 3) {
          //     return 'teacher';
          //   }else {
          //     return 'not registered';
          //   }
          // }
          // // return urole;
          // }

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF8d0c02),
                title: Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () {
                      logout(context);
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
              // drawer: const Adminbar(),
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
                                  child: Row(
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              '${data[index]['image']}'),
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
                                            Text('${data[index]['name']}'),
                                            Row(
                                              children: [
                                                Text('Status:',
                                                    style: TextStyle(
                                                        color: Colors.white)),

                                                // if(data[index]['role']==0)
                                                // {var};
                                                // getrole(data);
                                                Text('${data[index]['role']}',
                                                    style: TextStyle(
                                                        color: Colors.yellow)),
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
                                              // Text(
                                              //     ' Date: {data[index][date]}'),
                                              // Text(
                                              //     'Time: {data[index][ftime]}.00 - {data[index][ltime]}.00'),
                                              // Text(
                                              //     'Location: {data[index][note]}'),
                                              // Text(
                                              //     'Status : {data[index][status]}'),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              TextField(
                                                // controller: _tcName,
                                                decoration: InputDecoration(),
                                              ),
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
                                                  child: const Text('Student'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Disapproved');
                                                  },
                                                  child: const Text(
                                                    'Teacher',
                                                    style: TextStyle(
                                                        color: Colors.red),
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
                                        'role': 'student',
                                      };
                                      FirebaseFirestore.instance
                                          .collection('users')
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
                                        'role': 'teacher',
                                      };
                                      FirebaseFirestore.instance
                                          .collection('users')
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
