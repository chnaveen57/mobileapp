import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/appconstants.dart';

part '../hive/theater.g.dart';

@HiveType(typeId: AppConstants.theaterAdapterId)
class Theater {
  Theater({
    this.id,
    this.name,
    this.locationId,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String locationId;

  factory Theater.fromJson(Map<String, dynamic> json) => Theater(
        id: json["Id"],
        name: json["Name"],
        locationId: json["LocationId"],
      );
}
