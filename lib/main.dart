import 'package:bus_application/screens/help_and_support.dart';
import 'package:flutter/material.dart';
import 'package:bus_application/Credentials/Auth.dart';
import 'package:bus_application/models/tickets.dart';
import 'package:bus_application/screens/ticket_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:bus_application/profile.dart';
import 'package:bus_application/screens/booking.dart';
import 'package:bus_application/screens/payment.dart';
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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Authenticate(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: [
            Theme(
              data: Theme.of(context).copyWith(
                backgroundColor: Color.fromARGB(255, 25, 78, 109),
                dividerColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.white),
                textTheme: const TextTheme().apply(bodyColor: Colors.black),
              ),
              child: PopupMenuButton<int>(
                color: Color.fromARGB(255, 97, 178, 224),
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.people,
                            color: Color.fromARGB(255, 9, 56, 110), size: 30),
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
                        Icon(Icons.help,
                            color: Color.fromARGB(255, 9, 56, 110), size: 30),
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
                          color: Color.fromARGB(255, 108, 123, 189),
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
          color: Color.fromARGB(255, 25, 78, 109),
          child: Column(children: <Widget>[
            const Padding(padding: EdgeInsets.all(15)),
            const CircleAvatar(
              radius: 95,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(0, 35, 0, 15)),
              Container(
                margin: const EdgeInsets.all(10),
                height: 75.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Color.fromARGB(255, 111, 218, 203),
                      onPrimary: Colors.black),
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
                      primary: Color.fromARGB(255, 111, 218, 203),
                      onPrimary: Colors.black),
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
                      primary: Color.fromARGB(255, 111, 218, 203),
                      onPrimary: Colors.black),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpAndSupport(),
                      ),
                      (route) => true),
                  child: const Text("GET HELP", style: TextStyle(fontSize: 15)),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.all(10),
              //   height: 75.0,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         shape: const StadiumBorder(),
              //         primary: Color.fromARGB(255, 111, 218, 203),
              //         onPrimary: Colors.black),
              //     onPressed: () {
              //       Navigator.of(context).pushAndRemoveUntil(
              //           MaterialPageRoute(
              //               builder: (BuildContext context) =>
              //                   const PaymentScreen()),
              //           (route) => true);
              //     },
              //     child: const Text("PAYMENT", style: TextStyle(fontSize: 15)),
              //   ),
              // ),
            ]),
          ]),
        ),
      );

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const UserProfileBody()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HelpAndSupport()),
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
