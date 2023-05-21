// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_4/models/user_model.dart';
// import 'package:provider/provider.dart';
// class UserProvider2 with ChangeNotifier {
 
//       void streamnew() { 
//         final _userStream = FirebaseFirestore.instance.collection('users').snapshots();
//         StreamBuilder<QuerySnapshot>(
//         stream: _userStream,
//         builder: (context, snapshot) {
//           // connection error?
//           if (snapshot.hasError) {
//             return const Text('Connection error');
//           }

//           // connecting?
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text('Loading data...');
//           }

//           // data ready
//           // convert data to List
//           var data = snapshot.data!.docs;

//           // show data in ListView
//           return Text(data[0]['name']);
//           // ListView.builder(
//           //   itemCount: data.length,
//           //   itemBuilder: (context, index) {
//           //     return ListTile(
//           //       leading: IconButton(
//           //         onPressed: () {
//           //           // editData(data[index].id);
//           //           // _tcName.text = data[index]['name'];
//           //           // _tcAge.text = data[index]['age'].toString();
//           //         },
//           //         icon: const Icon(Icons.edit),
//           //       ),
//           //       title: Text(data[index]['name']),
//           //       // subtitle: Text("${data[index]['age']} years old"),
//           //       trailing: IconButton(
//           //         onPressed: () {
//           //           // deleteData(data[index].id);
//           //         },
//           //         icon: const Icon(Icons.delete),
//           //       ),
//           //     );
//           //   },
//           // );
//         },
//       );
//       }
// }