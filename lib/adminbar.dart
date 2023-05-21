import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/adminpage.dart';
import 'package:flutter_application_4/teacher/calender.dart';
import 'package:flutter_application_4/teacher/tsetting.dart';

// import 'appointment.dart';
// import 'thome.dart';
// import 'tsetting.dart';
import 'package:flutter/material.dart';

class Adminbar extends StatefulWidget {
  const Adminbar({super.key});

  @override
  State<Adminbar> createState() => _AdminbarState();
}

class _AdminbarState extends State<Adminbar> {
  final user = FirebaseAuth.instance.currentUser;
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  Future<void> getname(var email, String name) async {
    var query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    var docs = query.docs;
    if (docs.isNotEmpty) {
      if (docs[0]['email'] == user) {
        // return data[0][name];
      }
      var ans3 = docs[0][name];
      // return data[][name];
      return ans3;
    }
    docs[0]['name'];
  }
  // var ans = getname(data, 'name');

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
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
        var username;
        var userimage;
        var useremail;
        var userid;
        var data = snapshot.data!.docs;
        for (var i = 0; i < data.length; i++) {
          if (data[i]['email'] == email) {
            username = data[i]['name'];
            useremail = data[i]['email'];
            userid = data[i]['id'];
            userimage = data[i]['image'];
          }
        }
        // show data in ListView
        return Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text('${username}'),
                  accountEmail: Text('ID: ${userid}'),
                  currentAccountPicture: GestureDetector(
                      child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage('${userimage}'),
                    // child: Icon(Icons.person, color: Colors.white),
                  )),
                  decoration: BoxDecoration(color: Color(0xFF8d0c02))),
              ListTile(
                  leading: Icon(Icons.home_outlined, color: Color(0xFF8d0c02)),
                  title: Text('My Home'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: RouteSettings(arguments: email),
                            builder: (BuildContext context) {
                              return Adminpage();
                            }));
                  }),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF8d0c02)),
                title: Text('Appointment'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(arguments: email),
                          builder: (BuildContext context) {
                            return Appointment();
                          }));
                },
              ),
              Divider(color: Color(0xFF8d0c02), indent: 20.0),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xFF8d0c02)),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(arguments: email),
                          builder: (BuildContext context) {
                            return Tsetting();
                          }));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
