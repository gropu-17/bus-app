// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketsAdapter extends TypeAdapter<Tickets> {
  @override
  final int typeId = 1;

  @override
  Tickets read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tickets(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as DateTime,
      fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Tickets obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tocity)
      ..writeByte(1)
      ..write(obj.fromCity)
      ..writeByte(2)
      ..write(obj.ticketNumber)
      ..writeByte(3)
      ..write(obj.depatureDate)
      ..writeByte(4)
      ..write(obj.arrivalDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
