import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/theater.dart';

class MovieBookingModel{
  Movie movie;
  bool isReleased;
  List<Theater> theaters;
  MovieBookingModel({this.movie,this.isReleased,this.theaters});
}