import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_photoris/action/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'Menu.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
        ),
        backgroundColor: Colors.black12,
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 17),
                child: Center(
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  validator: (String? email) {
                    RequiredValidator(errorText: 'กรุณาป้อนข้อมูลส่วนนี้');
                    if (!email!.contains('@')) {
                      return 'กรุณากรอกอีเมล์ให้ถูกต้อง';
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(20)
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'someone@email.com',
                    labelText: 'ID Email',
                    labelStyle:
                        new TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  validator:
                      RequiredValidator(errorText: 'กรุณาป้อนข้อมูลส่วนนี้'),
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(20)
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Fullname',
                    labelStyle:
                        new TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  validator: (String? phone) {
                    RequiredValidator(errorText: 'กรุณากรอกข้อมูลส่วนนี้');
                    if (phone!.length < 10) {
                      return "กรุณากรอกข้อมูลให้ครบ";
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: phoneController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    labelStyle:
                        new TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  validator: (String? password) {
                    RequiredValidator(errorText: "กรุณากรอกข้อมูลส่วนนี้");
                    if (password!.length < 8) {
                      return 'กรุณากรอกมากกว่า 8 ตัวอักษร';
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(15)
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'Password',
                    labelStyle:
                        new TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 50,
                  right: 50,
                ),
                child: TextFormField(
                  validator: (String? password) {
                    RequiredValidator(errorText: "กรุณากรอกข้อมูลส่วนนี้");
                    if (password!.length < 8) {
                      return 'กรุณากรอกมากกว่า 8 ตัวอักษร';
                    }
                  },
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  controller: confirmpasswordController,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(15)
                  ],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    labelText: 'Confirm Password',
                    labelStyle:
                        new TextStyle(fontSize: 20, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: Colors.white)),
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
                    if (passwordController.text !=
                        confirmpasswordController.text) {
                      return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Error Password!'),
                                content: const Text('กรอกรหัสผ่านไม่ถูกต้อง'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final res = await Auth.register(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        phoneController.text,
                      );

                      if (res) {
                        if (FirebaseAuth.instance.currentUser == null) {
                          await Auth.login(
                              emailController.text, passwordController.text);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => theme()),
                        );
                      } else {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error!'),
                            content: const Text('อีเมลได้ถูกใช้แล้ว'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.pinkAccent,
                  child: Text(
                    'Create',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
        )));
  }
}
