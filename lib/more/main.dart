import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus-Ticket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bus-Ticket - Home'),
        ),
        body: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(40.0)),
            const Image(
                image: AssetImage('assets/logo.jpg'), width: 50, height: 75),
            Container(
              height: 50,
              color: Color.fromARGB(255, 25, 78, 109),
              child: const Center(child: Text('Bookings')),
            ),
            Container(
              height: 50,
              color: Color.fromARGB(255, 25, 78, 109),
              child: const Center(child: Text('Tickets')),
            ),
            Container(
              height: 50,
              color: Color.fromARGB(255, 25, 78, 109),
              child: const Center(child: Text('Stops')),
            ),
            Container(
              height: 75,
              color: Color.fromARGB(255, 25, 78, 109),
              child: const Center(child: Text('About Us')),
            ),
          ],
        ),
      ),
    );
  }
}
