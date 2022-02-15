import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yoTicket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('yoTicket - Home'),
        ),
        body: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(40.0)),
            const Image(
                image: AssetImage('assets/bus.jpg'), width: 50, height: 75),
            Container(
              height: 50,
              color: Colors.lime[800],
              child: const Center(child: Text('Bookings')),
            ),
            Container(
              height: 50,
              color: Colors.lime[600],
              child: const Center(child: Text('Tickets')),
            ),
            Container(
              height: 50,
              color: Colors.lime[400],
              child: const Center(child: Text('Stops')),
            ),
            Container(
              height: 75,
              color: Colors.lime[200],
              child: const Center(child: Text('About Us')),
            ),
          ],
        ),
      ),
    );
  }
}
