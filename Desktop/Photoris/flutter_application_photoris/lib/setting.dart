import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photoris/Login.dart';

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
                widget.onEdit();
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('บันทึก'),
              onTap: () async {
                widget.onSave();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('ออกจากระบบ'),
              onTap: () => {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('ออกจากระบบ'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => login(),
                            ),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}

class photographersetting extends StatefulWidget {
  final void Function() onEdit;
  final void Function() onSave;
  final void Function() onCancel;
  photographersetting({
    Key? key,
    required this.onEdit,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);
  @override
  State<photographersetting> createState() => _photographersettingState();
}

class _photographersettingState extends State<photographersetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
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
                widget.onEdit();
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt_rounded),
              title: Text('บันทึก'),
              onTap: () async {
                widget.onSave();
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
                        onPressed: () {
                          widget.onCancel();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('ออกจากระบบ'),
              onTap: () => {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('ออกจากระบบ'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => login(),
                            ),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
