// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  Booking read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      cost: fields[4] as int,
      id: fields[0] as String,
      seatID: fields[3] as String,
      seatNumbers: (fields[2] as List)?.cast<String>(),
      userId: fields[1] as String,
      movieName: fields[5] as String,
      movieTime: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.seatNumbers)
      ..writeByte(3)
      ..write(obj.seatID)
      ..writeByte(4)
      ..write(obj.cost)
      ..writeByte(5)
      ..write(obj.movieName)
      ..writeByte(6)
      ..write(obj.movieTime);
  }

  @override
  int get typeId => AppConstants.bookingAdapterId;
}
