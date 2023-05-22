import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_4/student/Contact.dart';
import 'package:flutter_application_4/student/Home_st.dart';
import 'package:flutter_application_4/student/settings.dart';
import 'pending.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
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

        // data ready
        // convert data to List
        var userimage;
        var username;
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
                    backgroundImage: NetworkImage('${userimage}'),
                    backgroundColor: Colors.grey,
                    // child: Icon(Icons.person, color: Colors.white)
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
                              return Home_st();
                            }));
                  }),
              ListTile(
                leading: Icon(Icons.person, color: Color(0xFF8d0c02)),
                title: Text('Status'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(arguments: email),
                          builder: (BuildContext context) {
                            return Pending();
                          }));
                },
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Color(0xFF8d0c02)),
                title: Text('Contact'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(arguments: email),
                          builder: (BuildContext context) {
                            return Contact();
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
                            return Settings2();
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
