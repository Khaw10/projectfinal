// class UserModel {
  // final String email;
  // final String id;
  // final String name;
  
  // final String password;
  // final String role;
//   // String userImage;
//   UserModel({
//     required this.email,
//     required this.id,
//     // this.userImage,
//     required this.name,
//     required this.password,
//     required this.role,
//   });
// }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// class Users {
//   // String displayName;
//   String email;
//   String id;
//   String name;
//   String password;
//   String role;
  
  
//   Users();

//   Users.fromMap(Map<String, dynamic> data) {
//     // displayName = data['displayName'];
    // email = data['email'];
    // id = data['id'];
    // name = data['name'];
    // password = data['password'];
    // role = data['role'];
    
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       // 'displayName': displayName,
      // 'email': email,
      // 'id': id,
      // 'name': name,
      // 'password': password,
      // 'role': role,
//     };
//   }
// }
// @immutable
class UserModel {
  final String email;
  final String id;
  final String name;
  
  final String password;
  final String role;
  final String uid;

  UserModel({
    required this.email,
    required this.id,
    // this.userImage,
    required this.name,
    required this.password,
    required this.role,
    required this.uid,
    });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'name': name,
      'password': password,
      'role': role,
      'Uid': uid,
    };
  }
}
//   factory UserModel.fromMap(Map<String, dynamic>? map) {
//     if (map == null) {
//       return const UserModel(email: "", id: "", name: "",password: "",role: "");
//     }

//     return UserModel(
//       email: map['id'] as String,
//       id: map['id'] as String,
//       name: map['fullName'] as String,
//       password: map['image'] as String,
//       role: map['id'] as String,

//     );
//   }
// }
