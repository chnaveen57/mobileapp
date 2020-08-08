// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/theater.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TheaterAdapter extends TypeAdapter<Theater> {
  @override
  Theater read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Theater(
      id: fields[0] as String,
      name: fields[1] as String,
      locationId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Theater obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.locationId);
  }

  @override
  int get typeId => AppConstants.theaterAdapterId;
}
