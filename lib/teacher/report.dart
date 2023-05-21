import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'tbar.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? uid;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      final status = [];
    });
    final status = [];
    final user = FirebaseAuth.instance.currentUser;
    final _userStream = FirebaseFirestore.instance
        .collection('bookings')
        .where("temail", isEqualTo: email)
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
          // FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //   if (user == null) {
          //     print('User is currently signed out!');
          //   } else {
          //     print('User is signed in!');
          //     uid = user.uid;
          //   }
          // });

          // var name;
          print(email);
          var data = snapshot.data!.docs;
          for (var i = 0; i < data.length; i++) {
            // if (data[i]['temail'] == email) {
            var ans = {
              'teacher': data[i]['teacher'],
              'temail': data[i]['temail'],
              'timage': data[i]['timage'],
              'sname': data[i]['sname'],
              'student': data[i]['student'],
              'simage': data[i]['simage'],
              'note': data[i]['note'],
              'date': data[i]['date'],
              'ftime': data[i]['ftime'],
              'ltime': data[i]['ltime'],
              'ftimeStamp': data[i]['ftimeStamp'],
              'ltimeStamp': data[i]['ltimeStamp'],
              'status': data[i]['status'],
            };
            status.add(ans);
            // }
          }
          print(status);
          // show data in ListView
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF8d0c02),
                title: Text('Home'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Report(),
                          settings: RouteSettings(arguments: email),
                        ),
                      );
                    },
                    icon: Icon(Icons.refresh),
                  ),
                ],
              ),
              drawer: Tbar(),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: status.length,
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
                                                  child: const Text('Approve'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop('Disapproved');
                                                  },
                                                  child: const Text(
                                                    'Disapproved',
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
                                      FirebaseFirestore.instance
                                          .collection('bookings')
                                          .doc(data[index].id)
                                          .delete()
                                          .then(
                                            (value) =>
                                                print('Document deleted!'),
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

// class Pending_Button extends StatelessWidget {
//   const Pending_Button({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 45,right: 45),
//         child: Container(
//           width: 100,
//           height: 100,
//           child: ElevatedButton(
            
//             child: Row(
//               children: [
//                 Container(
//                   child: CircleAvatar(
//                     backgroundImage: NetworkImage(
//                         'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png'),
//                     radius: 20,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Mr. Name User1'),
//                       Row(
//                         children: [
//                           Text('Status:', style: TextStyle(color: Colors.white)),
//                           Text('Pending', style: TextStyle(color: Colors.yellow)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             onPressed: () async {
//               String? answer = await showDialog(
//                 context: context,
//                 builder: (context) {
//                   //=========================================================
//                   return AlertDialog(
//                     backgroundColor: Colors.white,
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(' Date: Sat, 8/04/2023 '),
//                         Text('Time: 9.00 - 10.00'),
//                         Text('Location: S1 306'),
//                         Text('Status : Peding'),
//                       ],
//                     ),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: const [
//                         TextField(
//                           // controller: _tcName,
//                           decoration: InputDecoration(),
//                         ),
//                       ],
//                     ),
//                     actions: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop('Approve');
//                             },
//                             child: const Text('Approve'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop('Disapproved');
//                             },
//                             child: const Text(
//                               'Disapproved',
//                               style: TextStyle(color: Colors.red),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               );

//               if (answer == 'Approve') {
//                 // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
//                 //       (value) => print('Document deleted!'),
//                 //       onError: (e) => print('Error $e'),
//                 //     );
//               }
//               if (answer == 'Disapproved') {
//                 // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
//                 //       (value) => print('Document deleted!'),
//                 //       onError: (e) => print('Error $e'),
//                 //     );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
