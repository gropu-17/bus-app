import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'package:firebase_database/firebase_database.dart';

class Trips extends ChangeNotifier {
  dynamic trips = [];
  dynamic fetchedTrips = {};
  FirebaseDatabase database = FirebaseDatabase.instance;
  dynamic booked = "";

  Trips() {
    notifyListeners();
    getTrips();
  }

  dynamic getTrips() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("coaches");
    // Get the data once
    DatabaseEvent event = await ref.once();
    // Print the data of the snapshot
    fetchedTrips = event.snapshot.value;
    return (event.snapshot.value); // { "name": "John" }
  }

  dynamic registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {"message": "Account created"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return {"message": "Password is weak"};
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return {"message": "Account already exists. Please login"};
      }
    } catch (e) {
      print(e);
    }
    return {"message": "There is a connection issue"};
  }

  dynamic loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return {"message": "Login successful"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        return {"message": "No user found for that email."};
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        return {"message": "Wrong password provided for that user."};
      }
    } catch (e) {
      print(e);
    }
    return {"message": "There is a connection issue"};
  }

  dynamic getSeatsAvailable(String needle) async {
    booked = "";
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("bus-arrange/" + needle);
    // Get the data once
    DatabaseEvent event = await ref.once();
    // Print the data of the snapshot
    var tmp = event.snapshot.value;
    booked = tmp == null ? "0" : tmp;
    return (event.snapshot.value); // { "name": "John" }
  }

  dynamic bookSeat(
      Map<String, Object> booking, String needle, int seatnumber) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("bookings");
    await ref.update(booking);
    DatabaseReference seats =
        FirebaseDatabase.instance.ref("bus-arrange/" + needle);
    DatabaseEvent event = await seats.once();
    var tmp = event.snapshot.value;
    DatabaseReference newseats = FirebaseDatabase.instance.ref("bus-arrange");
    if (tmp == null) {
      await newseats.update({needle: seatnumber});
    } else {
      tmp = tmp.toString() + ",${seatnumber}";
      await newseats.update({needle: tmp});
    }
    return true;
  }

  Future loadData(uid) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("bookings");
    DatabaseEvent event = await ref.once();
    Object? tmp = event.snapshot.value;
    trips = tmp;
    print(tmp);
  }

  Future addData(
      {coach, toCity, fromCity, price, date, time, seatnumber, tickets}) async {
    final prefs = await SharedPreferences.getInstance();
    var node = [
      coach,
      toCity,
      fromCity,
      price,
      DateFormat('dd-MM-yyyy').format(date),
      time,
      seatnumber,
      tickets
    ];
    trips.add(node);
    notifyListeners();
    await prefs.setString('data', jsonEncode(trips));
    return true;
  }

  Future clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('data');
  }
}

class Trip {
  String coach = "";
  String price = "";
  String date = "";
  String time = "";
  String tickets = "";

  Trip() {}
}
