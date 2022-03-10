import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/Upgrade_Account.dart';
import 'package:flutter_application_photoris/action/user.dart';

import 'Profile.dart';
import 'action/photographer.dart';

class search extends StatelessWidget {
  final String? cost;
  final String? location;
  final String? category;
  search({
    Key? key,
    this.cost,
    this.category,
    this.location,
  }) : super(key: key);

  final auth = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(auth.uid)
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
                                      new Upgrade(
                                    viewOnly: false,
                                    userId: auth.uid,
                                  ),
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
            body: SingleChildScrollView(
                child: showcase(
              cost: cost,
              category: category,
              location: location,
            )),
          );
        });
  }
}

class showcase extends StatelessWidget {
  final String? cost;
  final String? location;
  final String? category;
  showcase({Key? key, this.category, this.cost, this.location})
      : super(key: key);

  final auth = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    dynamic streams = FirebaseFirestore.instance.collection("Photographer");

    if (cost != null && cost != "ไม่กำหนด") {
      streams = streams.where("cost", isEqualTo: cost);
    }

    if (location != null && location != "ไม่กำหนด") {
      streams = streams.where("location", isEqualTo: location);
    }

    if (category != null) {
      streams = streams.where("category", isEqualTo: category);
    }

    print(category);

    return StreamBuilder<QuerySnapshot>(
        stream: streams.where("disabled", isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final List<PhotographerModel> _photographers = [];

          snapshot.data!.docs.forEach((e) {
            final _p = PhotographerModel.fromJSON(e.data());
            _p.id = e.id;
            if (_p.uid != auth.uid) {
              _photographers.add(_p);
            }
          });

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
                    for (var p in _photographers)
                      FutureBuilder<DocumentSnapshot>(
                          future: p.user!.get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            }

                            final _user =
                                UserModel.fromJSON(snapshot.data!.data());
                            final photo = p.url!.isEmpty ? null : p.url!.first;

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Upgrade(
                                      viewOnly: true,
                                      userId: _user.userid!,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          photo != null
                                              ? "$photo"
                                              : "https://firebasestorage.googleapis.com/v0/b/photoris-6b7cc.appspot.com/o/iLjEDPHXgRZiO5voA1WGLOmr3c4I8d8QUQRrnMYLSX4.webp?alt=media&token=d9bc927f-dcdd-45b8-b884-3a4277dfbdf1",
                                          height: 200,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      top: 0,
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        width: 160,
                                        height: 55,
                                      ),
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
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.network(
                                                    "${_user.photo}",
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                "${_user.fullname}",
                                                overflow: TextOverflow.ellipsis,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                  ]),
            ),
          );
        });
  }
}
