// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../models/movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  Movie read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as String,
      name: fields[1] as String,
      releaseDate: fields[4] as String,
      actors: (fields[5] as List)?.cast<String>(),
      genre: (fields[6] as List)?.cast<String>(),
      imageUrl: fields[8] as String,
      runTime: fields[9] as String,
      story: fields[10] as String,
      startingDate: fields[11] as DateTime,
      endingDate: fields[12] as DateTime,
      locationId: fields[7] as String,
      theaterId: fields[3] as String,
      posterUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.posterUrl)
      ..writeByte(3)
      ..write(obj.theaterId)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.actors)
      ..writeByte(6)
      ..write(obj.genre)
      ..writeByte(7)
      ..write(obj.locationId)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.runTime)
      ..writeByte(10)
      ..write(obj.story)
      ..writeByte(11)
      ..write(obj.startingDate)
      ..writeByte(12)
      ..write(obj.endingDate);
  }

  @override
  int get typeId => AppConstants.movieAdapterId;
}
