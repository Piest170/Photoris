import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
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
              title: Text('Edit'),
              onTap: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                await FirebaseFirestore.instance
                    .collection('User')
                    .doc(auth.currentUser?.uid)
                    .snapshots();
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('Save'),
              onTap: () async {
                final FirebaseAuth auth = FirebaseAuth.instance;
                await FirebaseFirestore.instance
                    .collection('User')
                    .doc(auth.currentUser?.uid)
                    .update({'lineId': 'Copkung', 'detail': 'ผมเป็นคนหล่อ'});
                print(auth.currentUser?.uid);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('Delete Account'),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
