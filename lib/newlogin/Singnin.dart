// import 'dart:io';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/user_model.dart';
import 'package:flutter_application_4/newlogin/login.dart';
import 'package:flutter_application_4/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_application_4/providers/user_provider.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  XFile? _image;
  UploadTask? uploadTask;
  ImagePicker imagePicker = ImagePicker();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  String? downloadURL = null;
   User? user;
  selectFile() async {
    final result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result == null) return;
    setState(() {
      _image = result;
    });
  }
  Future<void> register() async {
    try {
      if (_fromKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context);
                        //     .showSnackBar(const SnackBar(
                        //   content: Text('Creat Account Success'),
                        // ));
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'images/$uniqueFileName';
    final fileToUpload = File(_image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(fileToUpload);

    final snapshot = await uploadTask!.whenComplete(() {});
    String? uid;
    downloadURL = await snapshot.ref.getDownloadURL();
    // if(downloadURL == null){
    //   downloadURL = 'https://firebasestorage.googleapis.com/v0/b/flutterprojectfinal-ec57e.appspot.com/o/images%2F1684502929196?alt=media&token=31ccdaa7-fe87-46bd-8318-e59caa262eb3';
    // }
    print("Download Link: $downloadURL");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      uid = user.uid;
      }});
      // const auth = getAuth();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
          var data = {
            'email':  emailController.text, 
            'password':  passwordController.text, 
            'name': nameController.text, 
            'id': idController.text,
            'image': downloadURL, 
            'uid': uid,
            'role': 'not registered'};
          FirebaseFirestore.instance.collection('users').add(data).then(
            (value) => print('Adding done!'),
            onError: (e) => print('Error $e'),
          );
    
    //       await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((userCredential) => {
    // // Signed in 
    //        user = userCredential.user});
    //       userProvider.addUserData(currentUser: user, id: '', email: '', name: '', password: '', role: ''
        
    //         );

    //   return user;
      // register OK
      // navigate back to login
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          ((route) => false),
        );
      }
      }
    } on FirebaseAuthException catch (e) {
      // register failed
      debugPrint('Error: ${e.code}');
    }
  }
  // userProvider.addUserData(
  //       currentUser: user,
  //       userEmail: user.email,
  //       userImage: user.photoURL,
  //       userName: user.displayName,
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8d0c02),
        title: const Text(
          'Creat account',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_image != null)
                          CircleAvatar(
                            backgroundColor: Colors.white,
                              radius: 40,
                                child:
                                ClipRRect(
                                borderRadius:BorderRadius.circular(50),
                                child: Image.file(
                                                    File(_image!.path),
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                  ),
                              )
                              ),
                        if (_image == null)
                          Container(
                              child: IconButton(
                                  onPressed: () {
                                    selectFile();
                                  },
                                  icon: const Icon(
                                    Icons.add_photo_alternate,
                                    color: Colors.pink,
                                    size: 20,
                                  )),
                                  
                                  ),
                      ],
                    ),
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: nameController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFFd1b266)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'Username',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: idController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFFd1b266)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'ID',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: emailController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFFd1b266)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter  Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: passwordController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFFd1b266)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: confirmpasswordController,
                    cursorColor: const Color(0xFFd1b266),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFFd1b266)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFFd1b266))),
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      } else if (value != passwordController.text) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              //========================================================================
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8d0c02)),
                    child: const Text('Creat Account'),
                    onPressed: register,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
