import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/services/contracts/theater_contract.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';

class MovieBookingViewModel extends BaseModel {
  TheaterContract _theaterContract;
  MovieBookingViewModel(this._theaterContract);
  Map<Theater, List<Seat>> theaterSeats;
  Map<Theater, List<Seat>> get seats => theaterSeats;
  List<Theater> _filteredTheaters;
  Map<Theater, List<Seat>> _filteredTheaterSeats;
  List<Theater> get filteredTheaters => _filteredTheaters;
  Map<Theater, List<Seat>> get filteredTheaterSeats => _filteredTheaterSeats;
  Future<void> getSeats(movie, theaters) async {
    changeState(ViewState.Busy);
    theaterSeats = await _theaterContract.getTheaterSeats(movie, theaters);
    changeState(ViewState.Idle);
  }

  void clearData() {
    _filteredTheaters = new List<Theater>();
    _filteredTheaterSeats = new Map<Theater, List<Seat>>();
  }

  void setFilteredTheaters(List<Theater> filteredTheaters) {
    _filteredTheaters = filteredTheaters;
    onChange();
  }

  void setFilteredTheaterSeats(List<Seat> seats, Theater theater) {
    _filteredTheaterSeats[theater] = seats;
    onChange();
  }
}
