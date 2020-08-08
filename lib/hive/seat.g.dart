// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/seat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatAdapter extends TypeAdapter<Seat> {
  @override
  Seat read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Seat(
      id: fields[0] as String,
      theaterId: fields[1] as String,
      seatsList: (fields[2] as List)?.cast<String>(),
      cost: fields[3] as int,
      timeSlot: fields[4] as String,
      date: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Seat obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.theaterId)
      ..writeByte(2)
      ..write(obj.seatsList)
      ..writeByte(3)
      ..write(obj.cost)
      ..writeByte(4)
      ..write(obj.timeSlot)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get typeId => AppConstants.seatAdapterId;
}
