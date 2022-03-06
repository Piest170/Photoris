import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/Upgrade_Account.dart';

import 'Profile.dart';

class search extends StatelessWidget {
  search({Key? key}) : super(key: key);

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
                backgroundColor: Colors.pinkAccent,
                elevation: 5,
                title: Text(
                  'Photoris',
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
                        child: Icon(Icons.account_circle, size: 30)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Profile()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: showcase()),
    );
  }
}

class showcase extends StatelessWidget {
  showcase({Key? key}) : super(key: key);

  final user = FirebaseFirestore.instance.collection('User').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: user,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                  children: [
                    for (int i = 0; i < 10; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Upgrade()));
                        },
                        child: Container(
                          // padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey,
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "photo/cat.jpeg",
                                    height: 200,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                top: 0,
                              ),
                              Positioned(
                                top: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.account_circle, size: 30),
                                      Text(
                                        "ช่างภาพแนะนำ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ]),
            ),
          );
        });
  }
}
