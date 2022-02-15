import 'package:flutter/material.dart';
import 'package:flutter_application_andrew/models/tickets.dart';
import 'package:hive_flutter/adapters.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Tickets>('ticketBox').listenable(),
        builder: (context, Box<Tickets> box, _) {
          if (box.values.isEmpty)
            return Center(
              child: Text("No tickets"),
            );
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              Tickets? currentTicket = box.getAt(index);
              return Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onLongPress: () {/* ... */},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        Text(currentTicket!.fromCity),
                        const SizedBox(height: 5),
                        Text(currentTicket.tocity),
                        const SizedBox(height: 5),
                        Text("${currentTicket.depatureDate}"),
                        const SizedBox(height: 5),
                        Text("${currentTicket.arrivalDate}"),
                        const SizedBox(height: 5),
                        Text("${currentTicket.ticketNumber}"),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
