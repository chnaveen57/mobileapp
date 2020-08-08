import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/hive/hive_constants.dart';
import 'package:movie_ticket_booking/hive/hive_db_intialization.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:movie_ticket_booking/services/contracts/booking_contract.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';

class BookingViewModel extends BaseModel {
  BookingContract _bookingContract;
  HiveDB _hiveDb;
  NetworkInfo _networkInfo;
  BookingViewModel(this._bookingContract, this._hiveDb, this._networkInfo);
  List<Booking> _bookings;
  List<Booking> get bookings => _bookings;
  Future<void> getBookings(String userID) async {
    changeState(ViewState.Busy);
    if (await _networkInfo.isConnected) {
      _bookings = await _bookingContract.getUserBookings(userID);
     await  _hiveDb.clearAll(HiveDBConstants.bookingBox);
      await _hiveDb.addAll(HiveDBConstants.bookingBox, _bookings);
    } else {
      _bookings = await _hiveDb.getAll<Booking>(HiveDBConstants.bookingBox);
    }
    changeState(ViewState.Idle);
  }
}
