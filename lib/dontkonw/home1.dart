import '../student/home.dart';
import '../student/pending.dart';
import 'package:flutter/material.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Home(),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Pending_Button();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

class Pending_Button extends StatelessWidget {
  const Pending_Button({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(left: 45,right: 45),
        child: Container(
          width: 100,
          height: 100,
          child: ElevatedButton(
            child: Row(
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://icons.iconarchive.com/icons/diversity-avatars/avatars/512/batman-icon.png'),
                    radius: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mr. Name User1'),
                      Row(
                        children: [
                          Text('Status:', style: TextStyle(color: Colors.white)),
                          Text('Pending', style: TextStyle(color: Colors.yellow)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onPressed: () async {
              String? answer = await showDialog(
                context: context,
                builder: (context) {
                  //=========================================================
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(' Date: Sat, 8/04/2023 '),
                        Text('Time: 9.00 - 10.00'),
                        Text('Location: S1 306'),
                        Text('Status : Peding'),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        TextField(
                          // controller: _tcName,
                          decoration: InputDecoration(),
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Approve');
                            },
                            child: const Text('Approve'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Disapproved');
                            },
                            child: const Text(
                              'Disapproved',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );

              if (answer == 'Approve') {
                // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
                //       (value) => print('Document deleted!'),
                //       onError: (e) => print('Error $e'),
                //     );
              }
              if (answer == 'Disapproved') {
                // FirebaseFirestore.instance.collection('uesrs').doc(docId).delete().then(
                //       (value) => print('Document deleted!'),
                //       onError: (e) => print('Error $e'),
                //     );
              }
            },
          ),
        ),
      ),
    );
  }
}
