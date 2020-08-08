import 'package:movie_ticket_booking/models/seat.dart';

class SeatLayoutModel{
  Seat seat;
  int seatCount;
  String movieName;
  SeatLayoutModel({this.movieName,this.seat,this.seatCount});
}