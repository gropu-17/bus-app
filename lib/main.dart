import 'package:flutter/material.dart';
import 'package:flutter_application_andrew/Credentials/Auth.dart';
import 'package:flutter_application_andrew/models/tickets.dart';
import 'package:flutter_application_andrew/screens/ticket_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_andrew/help_scren.dart';
import 'package:flutter_application_andrew/profile.dart';
import 'package:flutter_application_andrew/screens/about.dart';
import 'package:flutter_application_andrew/screens/booking.dart';
import 'package:flutter_application_andrew/screens/payment.dart';
import 'login/main.dart';
import 'services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool loggedIn = false;

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      // print('User is currently signed out!');
      loggedIn = false;
    } else {
      print('User is signed in!');
      loggedIn = true;
    }
  });

  //hiveDB
  // register adapter
  Hive.registerAdapter<Tickets>(TicketsAdapter());
  //initialize hive
  await Hive.initFlutter();
  //open box
  await Hive.openBox<Tickets>('ticketBox');

  runApp(ChangeNotifierProvider(
    create: (context) => Trips(),
    child: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  static const String title = 'Home Page';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    bool loggedIn = false;
    if (currentUser != null) {
      loggedIn = true;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Authenticate(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Homepage'),
          centerTitle: true,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                //backgroundColor: Color(),
                dividerColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
              ),
              child: PopupMenuButton<int>(
                color: Colors.green[100],
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.people, color: Colors.green, size: 30),
                        SizedBox(width: 8),
                        Text(
                          'Profile',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.help, color: Colors.green, size: 30),
                        SizedBox(width: 8),
                        Text(
                          'Help',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.orangeAccent,
                          size: 30,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Material(
          color: Colors.green[200],
          child: Column(children: <Widget>[
            const Padding(padding: EdgeInsets.all(15)),
            const CircleAvatar(
              radius: 95,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(0, 35, 0, 15)),
              Container(
                margin: const EdgeInsets.all(10),
                height: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.green[100],
                      onPrimary: Colors.orange),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => BookingPage()),
                  ),
                  child: const Text("BOOKING", style: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.green[100],
                      onPrimary: Colors.orange),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const TicketScreen()),
                        (route) => true);
                  },
                  child: const Text("TICKETS", style: TextStyle(fontSize: 15)),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10),
                height: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.green[100],
                      onPrimary: Colors.orange),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => About()),
                  ),
                  child: const Text("GET HELP", style: TextStyle(fontSize: 15)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.green[100],
                      onPrimary: Colors.orange),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PaymentScreen()),
                        (route) => true);
                  },
                  child: const Text("PAYMENT", style: TextStyle(fontSize: 15)),
                ),
              ),
            ]),
          ]),
        ),
      );

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => About()),
        );
        break;
      case 2:
        await FirebaseAuth.instance.signOut();
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => Login()),
      //   (route) => false,
      // );
    }
  }
}
/*© 2022 GitHub, Inc.
Terms
Privacy
Security
S*/
