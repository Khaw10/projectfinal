import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/student/home.dart';
import 'Widgets.dart';

class Home_st extends StatefulWidget {
  const Home_st({super.key});

  @override
  State<Home_st> createState() => _Home_stState();
}

class _Home_stState extends State<Home_st> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
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
          final List NameTeacher = [];

          // data ready
          // convert data to List
          var email = ModalRoute.of(context)!.settings.arguments as String;
          var username;
          var useremail;
          var userid;
          var data = snapshot.data!.docs;
          for (var i = 0; i < data.length; i++) {
            if (data[i]['role'] == 'teacher') {
              NameTeacher.add(data[i]['name']);
            }
          }
          // show data in ListView
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomSearchDelegate(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
                ),
              ],
              backgroundColor: Color(0xFF8d0c02),
              title: Text('Home'),
            ),
            drawer: Home(),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: NameTeacher.length,
                              itemBuilder: ((context, index) {
                                return MyScroll(
                                  NameAJ: NameTeacher[index],
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CustomSearchDelegate extends StatefulWidget {
  const CustomSearchDelegate({super.key});

  @override
  State<CustomSearchDelegate> createState() => _CustomSearchDelegateState();
}

class _CustomSearchDelegateState extends State<CustomSearchDelegate> {
  var name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8d0c02),
        title: Text('Search Teacher'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: SizedBox(
                width: 360,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a search Teacher',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('role', isEqualTo: 'teacher')
                    .snapshots(),
                initialData: null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs
                          .map((doc) => doc.data() as Map<String, dynamic>)
                          .toList();

                      final filteredData = name != null
                          ? data.where((item) =>
                              item['name'] != null &&
                              item['name']
                                  .toString()
                                  .toUpperCase()
                                  .contains(name.toUpperCase()))
                          : data;

                      return ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final item = filteredData.elementAt(index);
                          return MyScroll(
                            NameAJ: item['name'],
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
