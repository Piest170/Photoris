import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/Upgrade_Account.dart';
import 'package:flutter_application_photoris/setting.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Column(
          children: [
            Container(
              height: 125,
              width: double.infinity,
              child: AppBar(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(25))),
                backgroundColor: Colors.black12,
                elevation: 5,
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                        margin: EdgeInsets.only(
                          right: 50,
                        ),
                        child: Icon(Icons.menu, size: 30)),
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return setting();
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: Man()),
      backgroundColor: Colors.black12,
    );
  }
}

class Man extends StatelessWidget {
  const Man({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final customer = FirebaseFirestore.instance
        .collection('User')
        .doc(user?.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: customer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading..');
          }
          final dynamic _user = snapshot.data?.data();
          return Container(
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                  ),
                  radius: 60.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "${_user['fullname']}",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  "Customer",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  "ข้อมูลส่วนตัว",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Text(
                      "Name:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 50.0,
                    ),
                    Text(
                      "${_user['fullname']}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Tel:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 80.0,
                    ),
                    Text(
                      "${_user['phone']}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Email:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 55.0,
                    ),
                    Text(
                      "${_user['email']}",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Website:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      "${_user['website']}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Row(
                  children: [
                    Text(
                      "Line:",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 65.0,
                    ),
                    Text(
                      "${_user['lineId']}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
                  width: 350,
                  child: RaisedButton(
                    elevation: 5.0,
                    padding: EdgeInsets.all(10.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Upgrade()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.pinkAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            await FirebaseFirestore.instance
                                .collection('User')
                                .doc(auth.currentUser?.uid)
                                .update({'status': 'Photographer'});
                            print(auth.currentUser?.uid);
                            final user = await FirebaseFirestore.instance
                                .collection('User')
                                .doc(auth.currentUser?.uid)
                                .get();
                            final photographer = await FirebaseFirestore
                                .instance
                                .collection('Photographer')
                                .where('uid', isEqualTo: auth.currentUser?.uid)
                                .get();
                            if (photographer.docs.isEmpty) {
                              await FirebaseFirestore.instance
                                  .collection('Photographer')
                                  .add({
                                'User': user.reference,
                                'uid': auth.currentUser?.uid
                              });
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Upgrade()));
                          },
                          child: Text(
                            ' Upgrade Account',
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
