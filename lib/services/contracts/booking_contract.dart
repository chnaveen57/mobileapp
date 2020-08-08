import 'package:http/http.dart';
import 'package:movie_ticket_booking/models/booking.dart';

abstract class BookingContract{
  Future<List<Booking>> getUserBookings(String userID);
  Future<Response> addBooking(Booking booking);
}