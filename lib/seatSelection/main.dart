//import 'dart:math';

//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/cupertino.dart';

void main() {
  runApp(Container(
    color: Colors.orangeAccent,
  ));
  runApp(
    const Signup(),
  );
}

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData();

    return MaterialApp(
//theme drawer*****************************
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(primary: Colors.green),
      ),
      debugShowCheckedModeBanner: false,
//Scffold and App bar*********************
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green[200],
            title: const Text(
              'Sign up For An Account',
              style: TextStyle(fontSize: 30.0),
            )),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  // TextEditingController farmnameController = TextEditingController();
  // TextEditingController noOfHensController = TextEditingController();
  // TextEditingController typeOfHens = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(10)),
            const CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.green,
              // widthFactor: 1,
              //heightFactor: 1,
              child: Icon(
                Icons.account_box,
                size: 50,
                color: Colors.white,
              ),
            ),
            /*const Center(
            child: Text('Fill  in your details below'),
          ),*/
            // ignore: prefer_const_constructor
            //padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            // Center(
            //child:
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 75,
                  width: 200,
                  child: TextField(
                    controller: firstnameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        labelText: 'First Name'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 75,
                  width: 200,
                  child: TextField(
                    controller: lastnameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        labelText: 'Last Name'),
                  ),
                ),
              ],
            ),
            //),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 75,
                  width: 200,
                  child: TextField(
                    controller: contactController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        labelText: 'Contact'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 75,
                  width: 200,
                  child: TextField(
                    controller: mailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        labelText: 'E-mail'),
                  ),
                ),
              ],
            ),
            /*Container(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              height: 75,
              width: 1200,
              child: TextField(
                controller: farmnameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    labelText: 'Farm Name'),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(49, 10, 50, 10),
              height: 75,
              width: 2000,
              child: TextField(
                controller: typeOfHens,
                decoration: const InputDecoration(
                    hintText: 'enter the type of chicken reared',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    labelText: 'Type Reared'),
              ),
            ),*/
            Container(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              height: 75,
              width: 2000,
              child: TextField(
                maxLength: 15,
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              height: 75,
              width: 2000,
              child: TextField(
                maxLength: 15,
                obscureText: true,
                controller: password2,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  // ignore: avoid_print
                  print(firstnameController.text);
                  // ignore: avoid_print
                  print(lastnameController.text);
                  // ignore: avoid_print
                  print(contactController.text);
                  // ignore: avoid_print
                  print(mailController.text);
                  // ignore: avoid_print
                  //print(farmnameController.text);
                  // ignore: avoid_print
                  //print(noOfHensController.text);
                  // ignore: avoid_print
                  //print(typeOfHens.text);
                  // ignore: avoid_print
                  print(password.text);
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }
}
