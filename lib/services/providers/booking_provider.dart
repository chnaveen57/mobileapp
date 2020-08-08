import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking/helpers/enum.dart';
import 'package:movie_ticket_booking/helpers/http_client.dart';
import 'package:movie_ticket_booking/helpers/url_builder.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:movie_ticket_booking/services/contracts/booking_contract.dart';

class BookingProvider extends BookingContract {
  @override
  Future<http.Response> addBooking(Booking booking) async {
    var response = await HttpClientHelper.postData(
        UrlBuilder.buildUrl(UrlEndpoints.addBooking), booking);
    return response;
  }

  @override
  Future<List<Booking>> getUserBookings(String userID) async {
    var response = await HttpClientHelper.getData(UrlBuilder.buildUrl(
        UrlEndpoints.accessUserBookings,
        query: "/$userID"));
    return (json.decode(response.body) as List)
        .map((i) => Booking.fromJson(i))
        .toList();
  }
}
