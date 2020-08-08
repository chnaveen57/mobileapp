import 'package:http/http.dart';
import 'package:movie_ticket_booking/models/seat.dart';

abstract class SeatContract{
  Future<List<Seat>> getSeatsByTheaterId(String movieId,String theaterId);
  Future<Response> updateSeats(Seat seat);
  
}