import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'tickets.g.dart';

@HiveType(typeId: 1)
class Tickets {
  @HiveField(0)
  String tocity;
  @HiveField(1)
  String fromCity;
  @HiveField(2)
  int ticketNumber;
  @HiveField(3)
  DateTime depatureDate;
  @HiveField(4)
  DateTime arrivalDate;

  Tickets(this.tocity, this.fromCity, this.ticketNumber, this.depatureDate,
      this.arrivalDate);
}
