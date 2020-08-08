import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/models/theater.dart';

abstract class TheaterContract{
  Future<Map<Theater, List<Seat>>> getTheaterSeats(Movie movie, List<Theater> theaters);
}