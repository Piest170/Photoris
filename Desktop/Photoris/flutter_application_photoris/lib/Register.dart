import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_photoris/action/auth.dart';

import 'Menu.dart';

class register extends StatelessWidget {
  register({Key? key}) : super(key: key);

  get child => null;
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 50,
                right: 50,
              ),
              child: TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Fullname',
                  labelStyle: new TextStyle(fontSize: 20, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.white)),
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
                keyboardType: TextInputType.text,
                controller: phoneController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  labelStyle: new TextStyle(fontSize: 20, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.white)),
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
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
                left: 50,
                right: 50,
              ),
              child: TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                controller: confirmpasswordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  labelText: 'Confirm Password',
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
                  await Auth.register(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      phoneController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => theme()),
                  );
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                ),
              ),
            ),
          ],
        ))));
  }
}
