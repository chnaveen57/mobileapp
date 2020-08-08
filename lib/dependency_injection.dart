import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:kiwi/kiwi.dart';
import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/hive/hive_db_intialization.dart';
import 'package:movie_ticket_booking/services/contracts/booking_contract.dart';
import 'package:movie_ticket_booking/services/contracts/location_contract.dart';
import 'package:movie_ticket_booking/services/contracts/movie_contract.dart';
import 'package:movie_ticket_booking/services/contracts/seat_contract.dart';
import 'package:movie_ticket_booking/services/contracts/theater_contract.dart';
import 'package:movie_ticket_booking/services/providers/booking_provider.dart';
import 'package:movie_ticket_booking/services/providers/location_provider.dart';
import 'package:movie_ticket_booking/services/providers/movie_provider.dart';
import 'package:movie_ticket_booking/services/providers/seat_provider.dart';
import 'package:movie_ticket_booking/services/providers/theater_provider.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
import 'package:movie_ticket_booking/viewmodels/booking_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/home_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/movie_booking_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/movie_card_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/seat_layout_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/spalsh_view_model.dart';

class AppInversionOfControl {
  static KiwiContainer container;
  static void configure() {
    container = KiwiContainer();
    container.registerFactory((c) {
      return new BookingViewModel(c.resolve<BookingContract>(),
          c.resolve<HiveDB>(), c.resolve<NetworkInfo>());
    });
    container.registerFactory((c) {
      return new HomeViewModel(
          c.resolve<MovieContract>(),
          c.resolve<LocationContract>(),
          c.resolve<NetworkInfo>(),
          c.resolve<HiveDB>());
    });
    container.registerFactory((c) {
      return new MovieBookingViewModel(c.resolve<TheaterContract>());
    });
    container.registerFactory((c) {
      return new TheaterProvider(c.resolve<SeatContract>(), c.resolve<HiveDB>(),
          c.resolve<NetworkInfo>());
    });

    container.registerFactory((c) {
      return new SplashScreenModel();
    });
    container.registerFactory((c) {
      return new MovieCardViewModel();
    });
    
    container.registerFactory((c) {
      return new BaseModel
      ();
    });
    container.registerFactory((c) {
      return new DataConnectionChecker();
    });
    container.registerSingleton((c) {
      HiveDB.configure();
      return new HiveDB();
    });
    container.registerFactory<MovieContract>((c) => MovieProvider());
    container.registerFactory<NetworkInfo>(
        (c) => NetworkInfoImpl(c.resolve<DataConnectionChecker>()));
    container.registerFactory<LocationContract>((c) => LocationProvider());
    container.registerFactory<BookingContract>((c) => BookingProvider());
    container.registerFactory<SeatContract>((c) => SeatProvider());
    container.registerFactory<TheaterContract>((c) => TheaterProvider(
        c.resolve<SeatContract>(),
        c.resolve<HiveDB>(),
        c.resolve<NetworkInfo>()));
    container.registerFactory((c) {
      return new SeatLayoutViewModel(
          c.resolve<SeatContract>(), c.resolve<BookingContract>(),c.resolve<NetworkInfo>());
    });
  }

  static T getInstance<T>() {
    return container.resolve<T>();
  }
}
