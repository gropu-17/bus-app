//import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';
import "../services.dart";
import "../main.dart";

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Bus Ticket';
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    final PageController controller = PageController(initialPage: 0);

    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Color.fromARGB(255, 25, 78, 109),
          //  secondary: Colors.brown,
        ),
      ),
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bus Ticket',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: PageView(
          /// [PageView.scrollDirection] defaults to [Axis.horizontal].
          /// Use [Axis.vertical] to scroll vertically.
          controller: controller,
          children: <Widget>[
            MyStatefulWidget(
              controller: controller,
            ),
            Register(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final PageController controller;
  const MyStatefulWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            //  height: 150.0,
            width: 150.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logo.jpg',
                ),
              ),
              //shape: BoxShape.circle,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: const Text(
              'sign in',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //   Navigator.pushNamed(context,'homepage' );
              //forgot password screen
            },
            child: const Text(
              'Forgot Password',
              style: TextStyle(
                color: Color.fromARGB(255, 25, 78, 109),
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  var data = await services.loginUser(
                      nameController.text, passwordController.text);
                  if (data != null) {
                    if (data["message"] ==
                        "Wrong password provided for that user.") {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text(
                          'Wrong password provided for that user.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (data["message"] ==
                        "No user found for that email.") {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text(
                          'No user found for that email.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (data["message"] == "Login successful") {
                      const snackBar = SnackBar(
                        backgroundColor: Color.fromARGB(255, 25, 78, 109),
                        content: Text(
                          'Logging you in',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    } else {
                      var snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          data["message"],
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    }
                  }
                },
              )),
          Row(
            children: <Widget>[
              const Text("Does not have account?"),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 25, 78, 109)),
                ),
                onPressed: () {
                  widget.controller.animateTo(2,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                  //Signup screen
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}

class Register extends StatefulWidget {
  final PageController controller;
  const Register({Key? key, required this.controller}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
            //  height: 150.0,
            width: 150.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/logo.jpg',
                ),
              ),
              //shape: BoxShape.circle,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(40),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            height: 50,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () async {
                  var data = await services.registerUser(
                      nameController.text, passwordController.text);
                  if (data != null) {
                    if (data["message"] == "Password is weak") {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text(
                          'The password is weak',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (data["message"] ==
                        "Account already exists. Please login") {
                      const snackBar = SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text(
                          'Account already exists. Please login',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (data["message"] == "Account created") {
                      const snackBar = SnackBar(
                        backgroundColor: Color.fromARGB(255, 25, 78, 109),
                        content: Text(
                          'Account created. Logging you in now',
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    } else {
                      var snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          data["message"],
                          style: TextStyle(color: Colors.white),
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Future.delayed(Duration(seconds: 5), () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    }
                  }
                },
              )),
          Row(
            children: <Widget>[
              const Text("Already have an account? Sign in"),
              TextButton(
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 25, 78, 109)),
                ),
                onPressed: () {
                  widget.controller.animateTo(0,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeIn);
                  //Signup screen
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}

/*@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/fowl1.svg',
            width: 10.0,
            height: 10.0,
          ),
        ],
      ),
    ),
  );
}*/
