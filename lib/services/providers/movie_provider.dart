import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/helpers/enum.dart';
import 'package:movie_ticket_booking/helpers/http_client.dart';
import 'package:movie_ticket_booking/helpers/url_builder.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/services/contracts/movie_contract.dart';

class MovieProvider extends MovieContract {
  @override
  Future<List<List<Object>>> getMoviesByLocation(String locationId) async {
    List<Movie> nowShowingmovies = new List();
    List<Movie> comingSoonMovies = new List();
    DateTime date =
        DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));
    var response = await HttpClientHelper.getData(UrlBuilder.buildUrl(
        UrlEndpoints.accessMoviesByLocation,
        query: "/$locationId"));
    List<Movie> movies = (json.decode(response.body)["movies"] as List)
        .map((i) => Movie.fromJson(i))
        .toList();
    List<Theater> theaters = (json.decode(response.body)["theaters"] as List)
        .map((i) => Theater.fromJson(i))
        .toList();
    for (var movie in movies) {
      if (date.difference(movie.startingDate).inDays >= 0 &&
          !movie.endingDate.difference(date).isNegative) {
        nowShowingmovies.add(movie);
      }
      if (date.difference(movie.startingDate).isNegative) {
        comingSoonMovies.add(movie);
      }
    }
    return [nowShowingmovies, comingSoonMovies, theaters];
  }
}
