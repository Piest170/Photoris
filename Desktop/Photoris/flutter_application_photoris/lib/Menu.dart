// ignore_for_file: deprecated_member_use, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_photoris/Search.dart';
import 'package:flutter_application_photoris/Upgrade_Account.dart';
import 'package:flutter_application_photoris/action/user.dart';

import 'Profile.dart';

class theme extends StatelessWidget {
  theme({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(auth!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          final _user = UserModel.fromJSON(snapshot.data!.data());

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
                        GestureDetector(
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 30, top: 5, bottom: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                color: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    "${_user.photo}",
                                    width: 38,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (_user.status == "Photographer") {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Upgrade(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Profile(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(child: Menu()),
          );
        });
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Filtered(),
          SizedBox(height: 30),
          Suggest(),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildCostItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));
  DropdownMenuItem<String> buildLocationItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)));
}

class Suggest extends StatelessWidget {
  Suggest({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Photographer")
            .where("uid", isNotEqualTo: auth!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          }

          final List<dynamic> _photographers =
              snapshot.data!.docs.map((e) => e.data()).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "ช่างภาพแนะนำ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20, width: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                  children: [
                    for (int i = 0; i < _photographers.length; i++)
                      FutureBuilder<DocumentSnapshot>(
                          future: _photographers[i]["User"].get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            }

                            final dynamic _user = snapshot.data!.data();
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        "${_user['photo']}",
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
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.all(2),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  "${_user['photo']}",
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "${_user['fullname']}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 0.1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                  ],
                ),
              )
            ],
          );
        });
  }
}

class Filtered extends StatefulWidget {
  const Filtered({Key? key}) : super(key: key);

  @override
  State<Filtered> createState() => _FilteredState();
}

class _FilteredState extends State<Filtered> {
  final costs = [
    'ต่ำกว่า 1,000 บาท',
    '1,000-5,000 บาท',
    '5,000-10,000 บาท',
    '10,000-15,000 บาท',
    '15,000 บาทขึ้นไป'
  ];
  final locations = [
    'ภาคเหนือ',
    'ภาคใต้',
    'ภาคกลาง',
    'ภาคตะวันออกเฉียงเหนือ',
    'ภาคตะวันออก'
  ];
  String? cost;
  String? location;
  String? cate;

  selectbox(String name) {
    if (name == cate) {
      return BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 12)]);
    } else {
      return BoxDecoration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('ใส่งบประมาณที่ต้องการ'),
              value: cost,
              iconSize: 36,
              elevation: 4,
              isExpanded: true,
              style: TextStyle(
                color: Colors.grey[600],
              ),
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              items: costs.map(buildCostItem).toList(),
              onChanged: (value) => setState(() => this.cost = value),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(18),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('สถานที่'),
              value: location,
              iconSize: 36,
              elevation: 4,
              isExpanded: true,
              style: TextStyle(
                color: Colors.grey[600],
              ),
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              items: locations.map(buildLocationItem).toList(),
              onChanged: (value) => setState(() => this.location = value),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            spacing: 35.0,
            runSpacing: 20.0,
            direction: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "All_Photo";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("All_Photo"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.photo_album,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("All Photo"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "view";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("view"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.landscape_sharp,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("View"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "graduate";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("graduate"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("Graduate"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "wedding";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("wedding"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("Wedding"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "portrait";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("portrait"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("Portrait"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "product";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("product"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.liquor_rounded,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("Product"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    cate = "event";
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: selectbox("event"),
                  child: Column(
                    children: [
                      Icon(
                        Icons.event,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(0),
                        child: Text("Event"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            width: 220,
            child: RaisedButton(
              elevation: 5.0,
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => search()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.pinkAccent,
              child: Text(
                'ค้นหา',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
