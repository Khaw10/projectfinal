// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_4/models/user_model.dart';
// // import 'package:food_app/models/user_model.dart';

// class UserProvider with ChangeNotifier {
//   void addUserData({
//     required User currentUser,
//     required String email,
//     required String id,
//     required String name,
//     required String password,
//     required String role,
//   }) async {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .doc(currentUser.uid)
//         .set(
//       {
//         "email": email,
//         "id": id,
//         "name": name,
//         "password": password,
//         "role": role,
//         "uid": currentUser.uid,
//       },
//     );
//   }

//   UserModel currentData;
//   void getUserData() async {
//     UserModel userModel;
//     var value = await FirebaseFirestore.instance
//         .collection("usersData")
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .get();
//     if (value.exists) {
//       userModel = UserModel(
//         email: value.get("email"),
//         id: value.get("id"),
//         name: value.get("name"),
//         password: value.get("password"),
//         role: value.get("role"),
//         uid: value.get("uid"),
//       );
//       currentData = userModel;
//       notifyListeners();
//     }
//   }

//   UserModel get currentUserData {
//     return currentData;
//   }
// }