import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final user = FirebaseAuth.instance.currentUser;
  final _userStream =FirebaseFirestore.instance
        .collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD demo'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
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

          // data ready
          // convert data to List
          var data = snapshot.data!.docs;

          // show data in ListView
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(children: [
                Text(data[index]['name'])
              ],);
              // ListTile(
              //   leading: IconButton(
              //     onPressed: () {
              //       // editData(data[index].id);
              //       // _tcName.text = data[index]['name'];
              //       // _tcAge.text = data[index]['age'].toString();
              //     },
              //     icon: const Icon(Icons.edit),
              //   ),
              //   title: Text(data[index]['name']),
              //   // subtitle: Text("${data[index]['age']} years old"),
              //   trailing: IconButton(
              //     onPressed: () {
              //       // deleteData(data[index].id);
              //     },
              //     icon: const Icon(Icons.delete),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}