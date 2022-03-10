import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/Upgrade_Account.dart';
import 'package:flutter_application_photoris/action/user.dart';
import 'package:flutter_application_photoris/setting.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEdit = false;
  final auth = FirebaseAuth.instance.currentUser;
  final key = GlobalKey<_ManState>();

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
                            return usersetting(
                              onEdit: () {
                                setState(() {
                                  isEdit = true;
                                });
                              },
                              onSave: () {
                                key.currentState!.save();
                                setState(() {
                                  isEdit = false;
                                });
                              },
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(auth!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox();
            }
            final _user = UserModel.fromJSON(snapshot.data!.data());
            return SingleChildScrollView(
              child: Man(
                user: _user,
                isEdit: isEdit,
                key: key,
              ),
            );
          }),
      backgroundColor: Colors.black12,
    );
  }
}

class Man extends StatefulWidget {
  final bool isEdit;
  final UserModel user;
  Man({
    Key? key,
    required this.user,
    required this.isEdit,
  }) : super(key: key);

  @override
  State<Man> createState() => _ManState();
}

class _ManState extends State<Man> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final lineIdController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user.fullname!;
    phoneController.text = widget.user.phone!;
    websiteController.text = widget.user.website!;
    lineIdController.text = widget.user.lineId!;
    super.initState();
  }

  save() {
    widget.user.fullname = nameController.text;
    widget.user.phone = phoneController.text;
    widget.user.website = websiteController.text;
    widget.user.lineId = lineIdController.text;
    FirebaseFirestore.instance
        .collection("User")
        .doc(widget.user.userid)
        .set(widget.user.toJSON());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "${widget.user.photo}",
            ),
            radius: 60.0,
            backgroundColor: Colors.black,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            "${widget.user.fullname}",
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
              widget.isEdit
                  ? Expanded(
                      child: TextField(
                        controller: nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle:
                              new TextStyle(fontSize: 20, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "${widget.user.fullname}",
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
              widget.isEdit
                  ? Expanded(
                      child: TextField(
                        controller: phoneController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle:
                              new TextStyle(fontSize: 20, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "${widget.user.phone}",
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
                "${widget.user.email}",
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
              widget.isEdit
                  ? Expanded(
                      child: TextField(
                        controller: websiteController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle:
                              new TextStyle(fontSize: 20, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "${widget.user.website}",
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
              widget.isEdit
                  ? Expanded(
                      child: TextField(
                        controller: lineIdController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelStyle:
                              new TextStyle(fontSize: 20, color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      "${widget.user.lineId}",
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
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.0),
            width: 350,
            child: RaisedButton(
              elevation: 5.0,
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Upgrade(
                      viewOnly: false,
                      userId: "",
                    ),
                  ),
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
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Confirm Upgrade?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final auth =
                                          FirebaseAuth.instance.currentUser!;

                                      print(auth);

                                      await FirebaseFirestore.instance
                                          .collection('User')
                                          .doc(auth.uid)
                                          .update({'status': 'Photographer'});

                                      final user = await FirebaseFirestore
                                          .instance
                                          .collection('User')
                                          .doc(auth.uid)
                                          .get();

                                      final photographer =
                                          await FirebaseFirestore.instance
                                              .collection('Photographer')
                                              .where('uid', isEqualTo: auth.uid)
                                              .get();

                                      if (photographer.docs.isEmpty) {
                                        await FirebaseFirestore.instance
                                            .collection('Photographer')
                                            .add({
                                          'User': user.reference,
                                          'uid': auth.uid,
                                          "url": [],
                                          "status": true,
                                          "disabled": false,
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Upgrade(
                                              userId: auth.uid,
                                              viewOnly: false,
                                            ),
                                          ),
                                        );
                                      } else {
                                        await FirebaseFirestore.instance
                                            .collection('Photographer')
                                            .doc(photographer.docs.first.id)
                                            .update({
                                          "disabled": false,
                                          "status": true,
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Upgrade(
                                              userId: auth.uid,
                                              viewOnly: false,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
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
  }
}
