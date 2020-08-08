import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/screens/allbookings.dart';
import 'package:movie_ticket_booking/screens/home.dart';
import 'package:movie_ticket_booking/screens/movie_booking.dart';
import 'package:movie_ticket_booking/screens/seat_layout.dart';
import 'package:movie_ticket_booking/screens/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/bookings':
        return MaterialPageRoute(builder: (_) => AllBookings());
      case '/moviebooking':
      var moviebooking=settings.arguments;
        return MaterialPageRoute(builder: (_) => MovieBooking(movieBookingModel:moviebooking));
      case '/seatlayout':
      var seatlayout=settings.arguments;
        return MaterialPageRoute(builder: (_) => SeatLayOut(seatLayoutModel: seatlayout,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
