import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/appconstants.dart';
part '../hive/booking.g.dart';

@HiveType(typeId:AppConstants.bookingAdapterId)
class Booking {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userId;
  @HiveField(2)
  List<String> seatNumbers;
  @HiveField(3)
  String seatID;
  @HiveField(4)
  int cost;
  @HiveField(5)
  String movieName;
  @HiveField(6)
  String movieTime;
  Booking(
      {this.cost,
      this.id,
      this.seatID,
      this.seatNumbers,
      this.userId,
      this.movieName,
      this.movieTime});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['Id'],
      userId: json['UserId'],
      seatNumbers: json['SeatNumber'].toString().split(","),
      seatID: json['SeatID'],
      cost: json['Cost'],
      movieName: json['MovieName'],
      movieTime: json['MovieTime'],
    );
  }
  Map<dynamic, dynamic> toJson() => {
        'ID': id,
        'UserID': userId,
        'SeatNumber': seatNumbers,
        'SeatID': seatID,
        'Cost': cost,
        'MovieName': movieName,
        'MovieTime': movieTime,
      };
}
