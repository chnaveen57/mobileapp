import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/services/contracts/booking_contract.dart';
import 'package:movie_ticket_booking/services/contracts/seat_contract.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';

class SeatLayoutViewModel extends BaseModel {
  SeatContract _seatContract;
  NetworkInfo _networkInfo;
  BookingContract _bookingContract;
  bool _isConnected;
  bool _showSeatCapacity = false;
  SeatLayoutViewModel(this._seatContract, this._bookingContract,this._networkInfo);
  List<String> _seatNames = ["A", "B", "C", "D", "E", "F", "H", "I", "J", "K"];
  bool _isbooking = false;
  bool get isbooking => _isbooking;
  bool get isConnected=>_isConnected;
  List<String> get seatNames => _seatNames;
  bool get showSeatCapacity => _showSeatCapacity;
  Future<bool> setSeats(Seat seat) async {
    changeState(ViewState.Busy);
    var response = await _seatContract.updateSeats(seat);
    changeState(ViewState.Idle);
    return response.statusCode == 200;
  }
  void networkStatus()async{
    _isConnected= await _networkInfo.isConnected;
    onChange();
  }
  void updateIsBooking(bool isbooking) {
    _isbooking = isbooking;
    onChange();
  }

  void updateshowSeatCapacity(bool showSeatCapacity) {
    _showSeatCapacity = showSeatCapacity;
    onChange();
  }

  Future<bool> postBooking(Booking booking) async {
    changeState(ViewState.Busy);
    var response = await _bookingContract.addBooking(booking);
    changeState(ViewState.Idle);
    return response.statusCode == 200;
  }
}
