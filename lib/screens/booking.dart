import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_application_andrew/models/tickets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../services.dart';
import '../main.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: departDate,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2050, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        departDate = newDate;
      });
    }
  }

  void _selectDate2() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: departDate.add(Duration(days: 1)),
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2050, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        arrivalDate = newDate;
      });
    }
  }

  void addData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("coaches/simba");
    await ref.set({
      "no_of_seats": 38,
      'available_routes': {"Kampala To Jinja": "80000:1200,1230,1500,1900,2100"}
    });
  }

  bool isSearching = false;
  String fromCity = "";
  String toCity = "";
  int ticket = 0;
  DateTime departDate = DateTime.now();
  DateTime arrivalDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context);
    //addData();
    services.getTrips();
    return Scaffold(
      appBar: AppBar(
        title: const Text('YoTicket'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 370,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownSearch<String>(
                    mode: Mode.BOTTOM_SHEET,
                    items: [
                      "Kampala",
                      "Mbale",
                      "Jinja",
                      'Arua',
                      'Kasese',
                      'Mbarara'
                    ],
                    label: "To",
                    hint: "Arrival city",
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (data) {
                      setState(() {
                        toCity = data!;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownSearch<String>(
                    mode: Mode.BOTTOM_SHEET,
                    items: [
                      "Kampala",
                      "Mbale",
                      "Jinja",
                      'Arua',
                      'Kasese',
                      'Mbarara'
                    ],
                    label: "From",
                    hint: "Departure city",
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (data) {
                      setState(() {
                        fromCity = data!;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: _selectDate,
                          child: Text(departDate.isAfter(DateTime.now())
                              ? DateFormat('dd-MM-yyyy').format(departDate)
                              : ' DEPARTURE DATE'),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: _selectDate2,
                        child: Text(arrivalDate.isAfter(DateTime.now())
                            ? DateFormat('dd-MM-yyyy').format(arrivalDate)
                            : 'RETURN DATE'),
                      ),
                    ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: DropdownSearch<String>(
                    mode: Mode.MENU,
                    items: [
                      "1 Ticket",
                      "2 Tickets",
                      "3 Tickets",
                      "4 Tickets",
                      "5 Tickets",
                      "6 Tickets",
                    ],
                    label: "No. of Tickets",
                    hint: "Number of tickets",
                    popupItemDisabled: (String s) => s.startsWith('I'),
                    onChanged: (data) {
                      var tickets = data!;
                      setState(() {
                        ticket = int.parse(tickets[0]);
                      });
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: MaterialButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.orange,
                    onPressed: isSearching == false
                        ? () {
                            addInfo();
                            Map data = {
                              "fromCity": fromCity,
                              "toCity": toCity,
                              "tickets": ticket,
                              "departDate": departDate,
                              "arrivalDate0": arrivalDate
                            };

                            if (fromCity != "" &&
                                toCity != "" &&
                                ticket > 0 &&
                                departDate.isAfter(DateTime.now()) &&
                                arrivalDate.isAfter(DateTime.now())) {
                              setState(() {
                                isSearching = true;
                              });
                              Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                  isSearching = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BusOptions(
                                              busSearch: data,
                                            )),
                                  );
                                });
                              });
                            } else {
                              const snackBar = SnackBar(
                                content: Text('There is missing information'),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: isSearching == false
                        ? Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addInfo() {
    Box<Tickets> ticketBox = Hive.box<Tickets>('ticketBox');
    ticketBox.add(Tickets(fromCity, toCity, ticket, departDate, arrivalDate));
  }
}

class Contact {}

mixin Ticket {}

class BusOptions extends StatefulWidget {
  final busSearch;
  const BusOptions({Key? key, required this.busSearch}) : super(key: key);

  @override
  _BusOptionsState createState() => _BusOptionsState();
}

class _BusOptionsState extends State<BusOptions> {
  String appbarText = "";

  List bigData = [];

  @override
  void initState() {
    appbarText = widget.busSearch["fromCity"];
    appbarText += " To ";
    appbarText += widget.busSearch["toCity"];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context, listen: false);
    dynamic data = services.fetchedTrips;
    for (var v in data.keys) {
      for (var k in data[v]["available_routes"].keys) {
        if (appbarText == k) {
          var pool = data[v]["available_routes"][k];
          var price = pool.split(":")[0];
          List timeslots = pool.split(":")[1].split(",");
          for (int i = 0; i < timeslots.length; i++) {
            bigData.add([v, "${timeslots[i]}hrs", price]);
          }
        }
      }
    }
    bigData.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text(appbarText),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: bigData.length > 0
          ? ListView.builder(
              itemCount: bigData.length,
              itemBuilder: (context, index) {
                return DisplayCard(
                  coach: bigData[index][0],
                  price: bigData[index][2],
                  time: bigData[index][1],
                  toCity: widget.busSearch["toCity"],
                  fromCity: widget.busSearch["fromCity"],
                  date: widget.busSearch["departDate"],
                );
              })
          : Center(
              child: Text("There are no trips available"),
            ),
    );
  }
}

class DisplayCard extends StatelessWidget {
  final coach;
  final price;
  final time;
  final date;
  final toCity;
  final fromCity;
  const DisplayCard(
      {Key? key,
      required this.coach,
      required this.price,
      required this.time,
      required this.date,
      required this.toCity,
      required this.fromCity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 130,
      width: double.infinity,
      child: Card(
        child: InkWell(
          onTap: () async {
            var seatbook =
                "${coach} ${fromCity} To ${toCity} ${time.replaceAll("hrs", "")} ${DateFormat('dd-MM-yyyy').format(date)}";
            await services.getSeatsAvailable(seatbook);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SelectSeat(
                        coach: coach,
                        price: price,
                        time: time,
                        date: date,
                        toCity: toCity,
                        fromCity: fromCity,
                        booked: services.booked)));
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${coach}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Text(
                    "Leaves at ${time} on ${DateFormat('dd-MM-yyyy').format(date)}",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
                Text("Price: ${price}", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectSeat extends StatefulWidget {
  final coach;
  final price;
  final time;
  final date;
  final toCity;
  final fromCity;
  final booked;
  const SelectSeat(
      {Key? key,
      required this.coach,
      required this.price,
      required this.time,
      required this.date,
      required this.toCity,
      required this.fromCity,
      required this.booked})
      : super(key: key);

  @override
  _SelectSeatState createState() => _SelectSeatState();
}

class _SelectSeatState extends State<SelectSeat> {
  @override
  Widget build(BuildContext context) {
    List seats = [];

    int c = 2;
    int seatno = 1;
    for (int i = 0; i < 50; i++) {
      if (i == c && c < 50 - 5) {
        seats.add(Container());
        c += 5;
        continue;
      }
      Random random = new Random();
      int randomNumber = random.nextInt(7) + 1;
      var taken = [];
      taken = widget.booked.toString().split(",");

      seats.add(Seat(
        seatnumber: seatno,
        available: taken.contains(seatno.toString()) == false ? true : false,
        coach: widget.coach,
        price: widget.price,
        time: widget.time,
        date: widget.date,
        toCity: widget.toCity,
        fromCity: widget.fromCity,
      ));
      seatno++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Select preffered seat(s)"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              color: Colors.grey[50]),
          child: GridView.count(
            crossAxisCount: 5,
            primary: false,
            padding: EdgeInsets.all(10),
            crossAxisSpacing: 15,
            mainAxisSpacing: 5,
            children: [
              ...seats,
            ],
          ),
        ),
      ),
    );
  }
}

class Seat extends StatefulWidget {
  final seatnumber;
  final bool available;
  final coach;
  final price;
  final time;
  final date;
  final toCity;
  final fromCity;
  const Seat(
      {Key? key,
      required this.seatnumber,
      required this.available,
      required this.coach,
      required this.price,
      required this.time,
      required this.toCity,
      required this.fromCity,
      required this.date})
      : super(key: key);

  @override
  _SeatState createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  bool trying = false;
  @override
  Widget build(BuildContext context) {
    var services = Provider.of<Trips>(context);
    User? currentUser = FirebaseAuth.instance.currentUser;

    void showModal() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Confirm booking for ticket no ${widget.seatnumber}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Bus: ${widget.coach}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Price: ${widget.price}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Date and time: ${DateFormat('dd-MM-yyyy').format(widget.date)} ${widget.time}',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  child: trying == false
                      ? const Text('Book')
                      : CircularProgressIndicator(
                          color: Colors.green,
                        ),
                  onPressed: trying == false
                      ? () async {
                          setState(() {
                            trying = true;
                          });

                          var uuid = Uuid();
                          DateTime now = DateTime.now();

                          Map<String, Object> data = {
                            uuid.v1(): {
                              "user": currentUser != null
                                  ? currentUser.uid
                                  : "annonymous",
                              "coach": widget.coach,
                              "travelDetails":
                                  "${widget.fromCity} To ${widget.toCity}",
                              "price": widget.price,
                              "date":
                                  DateFormat('dd-MM-yyyy').format(widget.date),
                              "time": widget.time.replaceAll("hrs", ""),
                              "seatnumber": widget.seatnumber,
                              "datetime":
                                  DateFormat('yyyy-MM-dd – kk:mm').format(now)
                            }
                          };
                          var needle =
                              "${widget.coach} ${widget.fromCity} To ${widget.toCity} ${widget.time.replaceAll("hrs", "")} ${DateFormat('dd-MM-yyyy').format(widget.date)}";

                          var response = await services.bookSeat(
                              data, needle, widget.seatnumber);

                          if (response != null && response == true) {
                            trying = false;
                            Future<void> _showMyDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    true, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Success'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text(
                                            'Your ticket has been booked successfully',
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            _showMyDialog();
                            Future.delayed(Duration(seconds: 5), () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                            });
                          } else {
                            const snackBar = SnackBar(
                              content: Text("Sorry, your ticket wasn't booked"),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      : null,
                )
              ],
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: widget.available == true
          ? () {
              showModal();
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          '${widget.seatnumber}',
          textAlign: TextAlign.center,
        ),
        color: widget.available == true ? Colors.green[200] : Colors.red[200],
      ),
    );
  }
}
