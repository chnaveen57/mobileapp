import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/hive/hive_constants.dart';
import 'package:movie_ticket_booking/hive/hive_db_intialization.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/services/contracts/seat_contract.dart';
import 'package:movie_ticket_booking/services/contracts/theater_contract.dart';

class TheaterProvider extends TheaterContract {
  SeatContract _seatContract;
  HiveDB _hiveDB;
  NetworkInfo _networkInfo;
  TheaterProvider(this._seatContract, this._hiveDB, this._networkInfo);
  @override
  Future<Map<Theater, List<Seat>>> getTheaterSeats(
      Movie movie, List<Theater> theaters) async {
    var theaterSeats = new Map<Theater, List<Seat>>();
    for (var theater in theaters) {
      if (movie.theaterId == theater.id) {
        if (await _networkInfo.isConnected) {
          List<Seat> seats =
              await _seatContract.getSeatsByTheaterId(movie.id, theater.id);
          theaterSeats[theater] = seats;
          await _hiveDB.clearAll(HiveDBConstants.theaterSeatsBox);
          await _hiveDB.addAll(HiveDBConstants.theaterSeatsBox, seats);
        } else {
          List<Seat> seats =
              await _hiveDB.getAll<Seat>(HiveDBConstants.theaterSeatsBox);
          List<Seat> _seats = new List();
          for (var seat in seats) {
            if (seat.theaterId == theater.id) _seats.add(seat);
          }
          theaterSeats[theater] = _seats;
        }
      }
    }
    return theaterSeats;
  }
}
