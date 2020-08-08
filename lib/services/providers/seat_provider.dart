import 'dart:convert';

import 'package:movie_ticket_booking/helpers/enum.dart';
import 'package:movie_ticket_booking/helpers/http_client.dart';
import 'package:movie_ticket_booking/helpers/url_builder.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/services/contracts/seat_contract.dart';
import 'package:http/http.dart';

class SeatProvider extends SeatContract {
  @override
  Future<List<Seat>> getSeatsByTheaterId(
      String movieId, String theaterId) async {
    var response = await HttpClientHelper.getData(UrlBuilder.buildUrl(
        UrlEndpoints.getSeatsOfTheater,
        query: "/$theaterId/$movieId"));
    return (json.decode(response.body) as List)
        .map((i) => Seat.fromJson(i))
        .toList();
  }

  @override
  Future<Response> updateSeats(Seat seat) async {
    var response = await HttpClientHelper.putData(
        UrlBuilder.buildUrl(UrlEndpoints.updateSeats), seat);
    return response;
  }
}
