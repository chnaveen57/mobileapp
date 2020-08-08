import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/helpers/enum.dart';

class UrlBuilder{
  static buildUrl(UrlEndpoints urlEndpoint,{String query})
  {
    String baseUrl=AppConstants.baseUrl;
    switch(urlEndpoint){
      case UrlEndpoints.getSeatsOfTheater:
      return baseUrl+"seat"+query;
        break;
      case UrlEndpoints.accessUserBookings:
      return baseUrl+"booking"+query;
        break;
      case UrlEndpoints.accessLocation:
      return baseUrl+"location";
        break;
      case UrlEndpoints.accessMoviesByLocation:
      return baseUrl+"movie"+query;
        break;
      case UrlEndpoints.updateSeats:
      return baseUrl+"seat";
        break;
      case UrlEndpoints.addBooking:
      return baseUrl+"booking";
        break;
    }
  }
}