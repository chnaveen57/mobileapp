import 'dart:convert';
import 'package:movie_ticket_booking/helpers/enum.dart';
import 'package:movie_ticket_booking/helpers/http_client.dart';
import 'package:movie_ticket_booking/helpers/url_builder.dart';
import 'package:movie_ticket_booking/models/location.dart';
import 'package:movie_ticket_booking/services/contracts/location_contract.dart';

class LocationProvider extends LocationContract {
  @override
  Future<List<Location>> getLocations() async {
    var response = await HttpClientHelper.getData(
        UrlBuilder.buildUrl(UrlEndpoints.accessLocation));
    return (json.decode(response.body) as List)
        .map((i) => Location.fromJson(i))
        .toList();
  }
}
