import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/appconstants.dart';
part '../hive/movie.g.dart';
@HiveType(typeId: AppConstants.movieAdapterId)
class Movie {
  Movie({
    this.id,
    this.name,
    this.releaseDate,
    this.actors,
    this.genre,
    this.imageUrl,
    this.runTime,
    this.story,
    this.startingDate,
    this.endingDate,
    this.locationId,
    this.theaterId,
    this.posterUrl,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String posterUrl;
  @HiveField(3)
  String theaterId;
  @HiveField(4)
  String releaseDate;
  @HiveField(5)
  List<String> actors;
  @HiveField(6)
  List<String> genre;
  @HiveField(7)
  String locationId;
  @HiveField(8)
  String imageUrl;
  @HiveField(9)
  String runTime;
  @HiveField(10)
  String story;
  @HiveField(11)
  DateTime startingDate;
  @HiveField(12)
  DateTime endingDate;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["MovieId"],
        name: json["Name"],
        theaterId: json["TheaterId"],
        releaseDate: json["ReleaseDate"],
        locationId: json["LocationId"],
        actors: json["Actors"].toString().split(","),
        genre: json["Genre"].toString().split(","),
        imageUrl: json["ImageUrl"],
        runTime: json["RunTime"],
        story: json["Story"],
        posterUrl: json['PosterUrl'],
        startingDate: DateTime.parse(json["StartingDate"]),
        endingDate: DateTime.parse(json["EndingDate"]),
      );
}
