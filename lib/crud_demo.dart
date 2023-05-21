// CRUD: Create/ Read / Update / Delete

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudDemo extends StatefulWidget {
  const CrudDemo({super.key});

  @override
  State<CrudDemo> createState() => _CrudDemoState();
}

class _CrudDemoState extends State<CrudDemo> {
  // final List users = [
  //   {'name': 'Tom', 'age': 20},
  //   {'name': 'Lisa', 'age': 25},
  //   {'name': 'Peter', 'age': 19}
  // ];

  // stream from FireStore
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  // text editing controllers
  final _tcName = TextEditingController();
  final _tcAge = TextEditingController();

  // =========================== CRUD functions ====================
  Future<void> deleteData(String docId) async {
    String? answer = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sure to delete data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('OK');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // delete data
    if (answer == 'OK') {
      // print('OK');
      FirebaseFirestore.instance.collection('users').doc(docId).delete().then(
            (value) => print('Delete done!'),
            onError: (e) => print('Error $e'),
          );
    }
  }

  Future<void> addData() async {
    // clear text inputs
    _tcName.text = '';
    _tcAge.text = '';

    String? answer = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add new user'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tcName,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: _tcAge,
                decoration: const InputDecoration(hintText: 'Age'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('OK');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // add data
    if (answer == 'OK') {
      String name = _tcName.text;
      int age = int.parse(_tcAge.text);
      var data = {'name': name, 'age': age};
      // print(name);
      // print(age.toString());
      FirebaseFirestore.instance.collection('users').add(data).then(
            (value) => print('Adding done!'),
            onError: (e) => print('Error $e'),
          );
    }
  }

  Future<void> editData(String docId) async {
    String? answer = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit user'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tcName,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: _tcAge,
                decoration: const InputDecoration(hintText: 'Age'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop('OK');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // edit data
    if (answer == 'OK') {
      String name = _tcName.text;
      int age = int.parse(_tcAge.text);
      var data = {'name': name, 'age': age};
      // print(name);
      // print(age.toString());
      FirebaseFirestore.instance
          .collection('users')
          .doc(docId)
          .update(data)
          .then(
            (value) => print('Updating done!'),
            onError: (e) => print('Error $e'),
          );
    }
  }
  // ===============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD demo'),
        actions: [
          IconButton(
            onPressed: addData,
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
              return ListTile(
                leading: IconButton(
                  onPressed: () {
                    editData(data[index].id);
                    _tcName.text = data[index]['name'];
                    _tcAge.text = data[index]['age'].toString();
                  },
                  icon: const Icon(Icons.edit),
                ),
                title: Text(data[index]['name']),
                subtitle: Text("${data[index]['age']} years old"),
                trailing: IconButton(
                  onPressed: () {
                    deleteData(data[index].id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
