import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/student/pending.dart';
import 'package:intl/intl.dart';

class create_an_appointment extends StatefulWidget {
  // const create_an_appointment({super.key,
  // // required this.Name
  // });
  // final String Name;
  @override
  State<create_an_appointment> createState() => _create_an_appointmentState();
}

class _create_an_appointmentState extends State<create_an_appointment> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> itemsTimefirst = [
    '08',
    '09',
    '10',
    '13',
    '14',
    '15',
    '16',
  ];
  List<String> itemsTimeSec = [
    '08',
    '09',
    '10',
    '13',
    '14',
    '15',
    '16',
  ];
  String? valueChoosefirst = '08';
  String? valueChooseSec = '08';
  TextEditingController firstdateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime? ans;

  void initState() {
    super.initState();
    firstdateController.text = "";
  }

  TimeOfDay _timeOfDay = TimeOfDay(
    hour: 00,
    minute: 00,
  );
  TimeOfDay _timeOfDaySecond = TimeOfDay(
    hour: 00,
    minute: 00,
  );

  // show time picker method
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  //================================================================
  void _showTimePickerSecond() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDaySecond = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          String? uid;
          // data ready
          // convert data to List
          var username = ModalRoute.of(context)!.settings.arguments as String;
          var userimage;
          // var username;
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User is currently signed out!');
            } else {
              print('User is signed in!');
              uid = user.uid;
            }
          });
          var useremail;
          var userid;
          var data = snapshot.data!.docs;
          for (var i = 0; i < data.length; i++) {
            if (data[i]['name'] == username) {
              ;
              Teacher["email"] = data[i]['email'];
              Teacher["id"] = data[i]['id'];
              // Teacher["name"] = data[i]['name'];
              Teacher["image"] = data[i]['image'];
              // Teacher["name"] = data[i]['name'];
            }
          }

          print(Teacher);
          // show data in ListView
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Center(
                    child: Text(
                      "CREATE AN APPOINTMENT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF8d0c02),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 340,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage('${Teacher["image"]}'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Date',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Center(
                      child: (TextField(
                        controller: firstdateController,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Pick a date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat("yyyy-MM-dd").format(pickedDate);

                            setState(() {
                              firstdateController.text =
                                  formattedDate.toString();
                              ans = pickedDate;
                            });
                          } else {
                            print("Not selected");
                          }
                        },
                      )),
                    ),
                    //==============================================================
                    //เลือกเวลา
                    SizedBox(
                      height: 10,
                    ),

                    const Text(
                      'Time',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          //Time first
                          child: DropdownButton<String>(
                            value: valueChoosefirst,
                            items: itemsTimefirst
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.black),
                                    )))
                                .toList(),
                            onChanged: (item) =>
                                setState(() => valueChoosefirst = item),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(' to '),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          //Time sec
                          child: DropdownButton<String>(
                            value: valueChooseSec,
                            items: itemsTimeSec
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.black),
                                    )))
                                .toList(),
                            onChanged: (item) =>
                                setState(() => valueChooseSec = item),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Location',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // Center(
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //       setState(() {

                    //       });
                    //     },
                    //     ),
                    //   ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(0xFFc20211),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(125.0, 60.0),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1.0),
                                            side: BorderSide(
                                              width: 2.0,
                                              color: Colors.grey,
                                            )))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                var y = ans?.year;
                                var m = ans?.month;
                                var d = ans?.day;
                                var _ftime = int.parse(valueChoosefirst!);
                                var _ltime = int.parse(valueChooseSec!);
                                final ftime =
                                    DateTime(y!, m!, d!, _ftime, 00, 00);
                                final ltime =
                                    DateTime(y, m, d, _ltime, 00, 00);
                                Timestamp fTimeStamp =
                                    Timestamp.fromDate(ftime);
                                Timestamp lTimeStamp =
                                    Timestamp.fromDate(ltime);
                                // print(valueChoosefirst);
                                // print(valueChooseSec);
                                // print(ftime);
                                // print(ltime);
                                // print(uid);
                                // print(username);
                                print(firstdateController.text);
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .where("uid", isEqualTo: uid)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) => {
                                          querySnapshot.docs.forEach((doc) {
                                            //  print(doc["name"]);
                                            var data = {
                                              'teacher': username,
                                              'temail': Teacher["email"],
                                              'timage': Teacher["image"],
                                              'semail': doc['email'],
                                              'sname': doc['name'],
                                              'student': uid,
                                              'simage': doc['image'],
                                              'note': noteController.text,
                                              'date': firstdateController.text,
                                              'ftime': valueChoosefirst,
                                              'ltime': valueChooseSec,
                                              'ftimeStamp': fTimeStamp,
                                              'ltimeStamp': lTimeStamp,
                                              'status': 'Pending',
                                              'annotation': 'annotation',
                                            };
                                            FirebaseFirestore.instance
                                                .collection('bookings')
                                                .add(data)
                                                .then(
                                                  (value) =>
                                                      print('Adding done!'),
                                                  onError: (e) =>
                                                      print('Error $e'),
                                                );
                                          })
                                        });
                              });
                            },
                            child: Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF006600)),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(125.0, 60.0),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1.0),
                                            side: BorderSide(
                                              width: 2.0,
                                              color: Colors.grey,
                                            )))),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
