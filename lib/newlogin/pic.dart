import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Project_Mobile/main_page.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
// Declaring class variable
  XFile? _image;
  UploadTask? uploadTask;
  ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _tcName = TextEditingController();
  final _tcPrice = TextEditingController();
  final _tcDetails = TextEditingController();
  final _tcTel = TextEditingController();
  String? downloadURL = null;
  String? warning = null;
  int _price = 0;

  // function that let you pick an image from gallery
   selectFile() async {
    final result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result == null) return;
    setState(() {
      _image = result;
    });
  }

  // Upload the imgage to FireBase storage
   uploadFile() async {
    // Name the file with time to the milisecond
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'images/$uniqueFileName';
    final fileToUpload = File(_image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(fileToUpload);

    final snapshot = await uploadTask!.whenComplete(() {});

    downloadURL = await snapshot.ref.getDownloadURL();
    print("Download Link: $downloadURL");
    print(_tcPrice.text);
    String price = _tcPrice.text;
    print(price);
  }

  // Uploading the data to FireBase DB
   addCollectionToFireBase(
      String name, int price, String detail, int tel) async {
    await uploadFile();
    var data = {
      'name': name,
      'price': price,
      'image': downloadURL,
      'detail': detail,
      'tel': tel,
    };
    FirebaseFirestore.instance.collection('image').add(data).then(
          (value) => print('Adding done!'),
          onError: (e) => print('Error $e'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 150,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'room to sell',
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (_image != null)
                      Expanded(
                          flex: 20,
                          child: Container(
                            child: Image.file(
                              File(_image!.path),
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          )),
                    if (_image == null)
                      Container(
                          child: IconButton(
                              onPressed: () {
                                selectFile();
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate,
                                color: Colors.pink,
                                size: 50,
                              ))),
                  ],
                )),
            // Product Name field
            Expanded(
                flex: 5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLength: 30,
                        controller: _tcName,
                        decoration: const InputDecoration(
                          hintText: 'Room name',
                          hintStyle: TextStyle(color: Colors.pink),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Name for your product';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        maxLength: 9,
                        controller: _tcPrice,
                        decoration: const InputDecoration(
                          hintText: 'Price (Thai Baht ฿ and no decimal point)',
                          hintStyle: TextStyle(color: Colors.pink),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          } else if (int.tryParse(value) == null) {
                            return 'Please input only number with no decimal point';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        maxLength: 250,
                        controller: _tcDetails,
                        decoration: const InputDecoration(
                          hintText: 'Details',
                          hintStyle: TextStyle(color: Colors.pink),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter details of the product';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLength: 15,
                        controller: _tcTel,
                        decoration: const InputDecoration(
                          hintText: 'Tel. (Number your phone)',
                          hintStyle: TextStyle(color: Colors.pink),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a numbar ur phone';
                          } else if (int.tryParse(value) == null) {
                            return 'Please input only number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )),

            // Details field
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            _image != null) {
                          String name = _tcName.text;
                          String detail = _tcDetails.text;
                          int Tel = int.parse(_tcTel.text.trim());
                          int price = int.parse(_tcPrice.text.trim());
                          // show loading
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              });
                          // adding data to collection
                          await addCollectionToFireBase(
                              name, price, detail, Tel);
                          // pop loading circle
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Uploaded'),
                          ));
                          // Remove everything
                          setState(() {
                            _image = null;
                            warning = null;
                            _tcName.clear();
                            _tcPrice.clear();
                            _tcDetails.clear();
                            _tcTel.clear();
                          });
                        } else if (_image == null) {
                          setState(() {
                            warning = "Make sure an image is selected";
                          });
                        } else {
                          setState(() {
                            warning = "";
                          });
                        }
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.2,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (warning != null)
                    Text(
                      warning!,
                      style: TextStyle(color: Colors.red[800]),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
    //);
  }
}
