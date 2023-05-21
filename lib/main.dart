import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_4/Logindemo.dart';
import 'package:flutter_application_4/allsignin.dart';
import 'package:flutter_application_4/Logindemo/login_demo.dart';
import 'package:flutter_application_4/newlogin/login.dart';
import 'package:flutter_application_4/providers/product_provider.dart';
import 'package:flutter_application_4/providers/user_provider.dart';
import 'package:flutter_application_4/services/auth_notifier.dart';
// import 'package:flutter_application_4/logindemo.dart';
import 'package:flutter_application_4/student/Home_st.dart';
import 'package:flutter_application_4/teacher/calender.dart';
import 'package:flutter_application_4/dontkonw/tsignin.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
     home: Login(),
     debugShowCheckedModeBanner: false,
   ));
 }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<AuthNotifier>(
//           create: (context) => AuthNotifier(),
//         ),
//         ChangeNotifierProvider<UserProvider>(
//           create: (context) => UserProvider(),
//         ),

//       ],
//       child: MaterialApp(
//         // theme: ThemeData(
//         //     primaryColor: primaryColor,
//         //     scaffoldBackgroundColor: scaffoldBackgroundColor),
//         debugShowCheckedModeBanner: false,
//         home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapShot) {
//             // if (snapShot.hasData) {
//             //   return HomeScreen();
//             // }
//             return Login();
//           },
//         ),
//       ),
//     );
//   }
// }
