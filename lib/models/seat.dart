import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/appconstants.dart';
part '../hive/seat.g.dart';

@HiveType(typeId: AppConstants.seatAdapterId)
class Seat {
  Seat({
    this.id,
    this.theaterId,
    this.seatsList,
    this.cost,
    this.timeSlot,
    this.date,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String theaterId;
  @HiveField(2)
  List<String> seatsList;
  @HiveField(3)
  int cost;
  @HiveField(4)
  String timeSlot;
  @HiveField(5)
  String date;
  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["Id"],
        date: json["Id"].toString().split(" ")[0],
        timeSlot: json["Id"].toString().split(" ")[1].split(",")[0],
        theaterId: json["TheaterId"],
        seatsList: List<String>.from(json["SeatsList"].map((x) => x)),
        cost: json["Cost"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "TheaterId": theaterId,
        "SeatsList": List<String>.from(seatsList.map((x) => x)),
        "Cost": cost,
      };
}
