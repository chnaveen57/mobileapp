import 'package:movie_ticket_booking/models/location.dart';

abstract class LocationContract{
  Future<List<Location>> getLocations();
}