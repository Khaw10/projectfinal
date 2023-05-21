// import 'signin.dart';
// import 'package:flutter/material.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//       padding: const EdgeInsets.all(15),
//       child: ListView(
//         children: <Widget>[
//           Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.all(5),
//               child: const Text(
//                 'Create your account',
//                 style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20),
//               )),
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//               ],
//               shape: BoxShape.circle,
//               image: const DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                     'https://www.mfu.ac.th/fileadmin/prfiles/MFU_logo/logo_mfu_3d_colour.png'),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               children: [
//                 makeInput(label: "Name"),
//                 makeInput(label: "Username"),
//                 makeInput(label: "User ID"),
//                 makeInput(label: "Email"),
//                 makeInput(label: "Password", obsureText: true)
//               ],
//             ),
//           ),
//           Container(
//               height: 50,
//               padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
//               child: ElevatedButton(
//                 child: const Text('Sign In'),
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Signin(),
//                       ),
//                       (route) => false);
//                   print(nameController.text);
//                   print(passwordController.text);
//                 },
//               )),
//         ],
//       ),
//     ));
//   }
// }

// Widget makeInput({label, obsureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         label,
//         style: const TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       const SizedBox(
//         height: 1,
//       ),
//       TextField(
//         obscureText: obsureText,
//         decoration: const InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.grey,
//             ),
//           ),
//           border:
//               OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
//         ),
//       ),
//       const SizedBox(
//         height: 10,
//       )
//     ],
//   );
// }
