import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Profile.dart';

class usersetting extends StatefulWidget {
  final void Function() onEdit;
  final void Function() onSave;
  usersetting({
    Key? key,
    required this.onEdit,
    required this.onSave,
  }) : super(key: key);

  @override
  State<usersetting> createState() => _usersettingState();
}

class _usersettingState extends State<usersetting> {
  // TextEditingController _textEditingController = TextEditingController();
  // String? Textvalue;
  // String? Dialog;

  // Future<void> _displayTextInputDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('TextField in Dialog'),
  //           content: TextField(
  //             onChanged: (value) {
  //               setState(() {
  //                 Textvalue = value;
  //               });
  //             },
  //             controller: _textEditingController,
  //             decoration: InputDecoration(hintText: "Text Field in Dialog"),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               color: Colors.red,
  //               textColor: Colors.white,
  //               child: Text('CANCEL'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             FlatButton(
  //               color: Colors.green,
  //               textColor: Colors.white,
  //               child: Text('OK'),
  //               onPressed: () {
  //                 setState(() {
  //                   Dialog = Textvalue;
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('แก้ไข'),
              onTap: () async {
                widget.onEdit();
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('บันทึก'),
              onTap: () async {
                // final FirebaseAuth auth = FirebaseAuth.instance;
                // await FirebaseFirestore.instance
                //     .collection('User')
                //     .doc(auth.currentUser?.uid)
                //     .update({'lineId': 'Copkung', 'detail': 'ผมเป็นคนหล่อ'});
                widget.onSave();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class photographersetting extends StatefulWidget {
  final void Function(dynamic user) onEdit;
  final void Function() onSave;
  photographersetting({
    Key? key,
    required this.onEdit,
    required this.onSave,
  }) : super(key: key);
  @override
  State<photographersetting> createState() => _photographersettingState();
}

class _photographersettingState extends State<photographersetting> {
  // TextEditingController _textEditingController = TextEditingController();
  // String? Textvalue;
  // String? Dialog;

  // Future<void> _displayTextInputDialog(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('TextField in Dialog'),
  //           content: TextField(
  //             onChanged: (value) {
  //               setState(() {
  //                 Textvalue = value;
  //               });
  //             },
  //             controller: _textEditingController,
  //             decoration: InputDecoration(hintText: "Text Field in Dialog"),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               color: Colors.red,
  //               textColor: Colors.white,
  //               child: Text('CANCEL'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             FlatButton(
  //               color: Colors.green,
  //               textColor: Colors.white,
  //               child: Text('OK'),
  //               onPressed: () {
  //                 setState(() {
  //                   Dialog = Textvalue;
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('แก้ไข'),
              onTap: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final user = await FirebaseFirestore.instance
                    .collection('User')
                    .doc(auth.currentUser?.uid)
                    .get();
                widget.onEdit(user.data());
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('บันทึก'),
              onTap: () async {
                widget.onSave();
                // final FirebaseAuth auth = FirebaseAuth.instance;
                // await FirebaseFirestore.instance
                //     .collection('User')
                //     .doc(auth.currentUser?.uid)
                //     .update({'lineId': 'Copkung', 'detail': 'ผมเป็นคนหล่อ'});
                // print(auth.currentUser?.uid);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('ยกเลิกการเป็นช่างภาพ'),
              onTap: () => {
                showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('ยกเลิกการเป็นช่างภาพหรือไม่'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // final FirebaseAuth auth = FirebaseAuth.instance;
                                // await FirebaseFirestore.instance
                                //     .collection('Photographer')
                                //     .doc(auth.currentUser?.uid)
                                //     .delete();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ))
              },
            ),
          ],
        ),
      ),
    );
  }
}
