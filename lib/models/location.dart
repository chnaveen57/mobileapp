import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/appconstants.dart';

part '../hive/location.g.dart';

@HiveType(typeId: AppConstants.locationAdapterId)
class Location {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  Location({this.name, this.id});
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['Id'],
      name: json['Name'],
    );
  }
}
