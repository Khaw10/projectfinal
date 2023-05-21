// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'create_an_appointment.dart';

// class MyScroll extends StatefulWidget {
//   const MyScroll({super.key, required this.NameAJ});
//   final String NameAJ;

//   @override
//   State<MyScroll> createState() => _MyScrollState();
// }

// class _MyScrollState extends State<MyScroll> {
//   @override
//   Widget build(BuildContext context) {
//   final _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final user = FirebaseAuth.instance.currentUser;
//   final _userStream =FirebaseFirestore.instance
//         .collection('users').snapshots();
//     return StreamBuilder<QuerySnapshot>(
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
//           final Map Teacher = {};

//           // data ready
//           // convert data to List
//           var email = ModalRoute.of(context)!.settings.arguments as String;
//           var userimage;
//           var username;
//           var useremail;
//           var userid;
//           var data = snapshot.data!.docs;
//           for (var i=0;i<data.length;i++){
//             if(data[i]['name'] == widget.NameAJ){;
//               Teacher["email"] = data[i]['email'];
//               Teacher["id"] = data[i]['id'];
//               Teacher["name"] = data[i]['name'];
//               Teacher["image"] = data[i]['image'];
//               // Teacher["name"] = data[i]['name'];
//             }
//           }
//           // print(Teacher);
//           // show data in ListView
//       return Padding(
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           width: 340,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Color(0xFF1f222b),
//             borderRadius: BorderRadius.circular(40),
//           ),
//           child: Expanded(

//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage('${Teacher["image"]}'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: SizedBox(
//                     width: 200,

//                     child: Text(
//                       widget.NameAJ,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, right: 50),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => (create_an_appointment()),
//                             settings: RouteSettings(arguments: Teacher["name"]),
//                             ),
//                       );
//                     },
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Icon(
//                         Icons.add_circle_sharp,
//                         size: 30,
//                         color: Color(0xFFd1b266),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );});
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'create_an_appointment.dart';

class MyScroll extends StatefulWidget {
  const MyScroll({super.key, required this.NameAJ});
  final String NameAJ;

  @override
  State<MyScroll> createState() => _MyScrollState();
}

class _MyScrollState extends State<MyScroll> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();
    final user = FirebaseAuth.instance.currentUser;
    final _userStream =
        FirebaseFirestore.instance.collection('users').snapshots();
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
          final Map Teacher = {};

          // data ready
          // convert data to List
          // var email = ModalRoute.of(context)!.settings.arguments as String;
          var userimage;
          var username;
          var useremail;
          var userid;
          var data = snapshot.data!.docs;
          for (var i = 0; i < data.length; i++) {
            if (data[i]['name'] == widget.NameAJ) {
              Teacher["email"] = data[i]['email'];
              Teacher["id"] = data[i]['id'];
              Teacher["name"] = data[i]['name'];
              Teacher["image"] = data[i]['image'];
              // Teacher["name"] = data[i]['name'];
            }
          }
          // print(Teacher);
          // show data in ListView
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 340,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(60),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('${Teacher["image"]}'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 180,
                      child: Text(
                        widget.NameAJ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => (create_an_appointment()),
                            settings: RouteSettings(arguments: Teacher["name"]),
                          ),
                        );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.add_circle_sharp,
                          size: 30,
                          color: Color(0xFF8d0c02),
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
