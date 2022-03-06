import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter_application_photoris/action/auth.dart';

import 'Menu.dart';
import 'Register.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);

  get child => null;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  "Photoris",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: Text(
                "Login  to  continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Image.asset("photo/Photoris01.png", height: 280, width: 280),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
              ),
              child: TextFormField(
                validator: MultiValidator([
                  RequiredValidator(errorText: 'กรุณาป้อนอีเมล์'),
                  EmailValidator(errorText: 'กรุณากรอกอีเมล์ให้ถูกต้อง')
                ]),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'someone@email.com',
                  labelText: 'ID Email',
                  labelStyle: new TextStyle(fontSize: 20, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 50,
                right: 50,
              ),
              child: TextFormField(
                validator: RequiredValidator(errorText: 'กรุณาป้อนรหัสผ่าน'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'password',
                  labelText: 'Password',
                  labelStyle: new TextStyle(fontSize: 20, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.white)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 45.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 5.0,
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  final result = await Auth.login(
                      emailController.text, passwordController.text);
                  if (result == null) {
                    return showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('Error!'),
                              content: const Text(
                                  'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => theme()),
                    );
                  }
                  print(result);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.pinkAccent,
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => register()),
                      );
                    },
                    child: Text(
                      "Create Account Now!",
                      style: TextStyle(
                          fontSize: 15, color: Theme.of(context).accentColor),
                    )),
              ],
            ),
          ],
        ))));
  }
}
