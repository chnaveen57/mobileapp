import 'package:hive/hive.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:movie_ticket_booking/models/location.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:path_provider/path_provider.dart';

class HiveDB {
  static void configure() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(BookingAdapter());
    Hive.registerAdapter(MovieAdapter());
    Hive.registerAdapter(TheaterAdapter());
    Hive.registerAdapter(LocationAdapter());
    Hive.registerAdapter(SeatAdapter());
  }

  Future<List<T>> getAll<T>(String boxName) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      return (box != null && box.values != null)
          ? box.values.toList()
          : new List<T>();
    } catch (ex) {
      print(ex);
      return null;
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> addAll<T>(String boxName, dynamic values) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      await box.addAll(values);
    } catch (ex) {
      print(ex);
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }

  Future<void> clearAll<T>(String boxName) async {
    Box box;
    try {
      if (Hive.isBoxOpen(boxName))
        box = Hive.box(boxName);
      else
        box = await Hive.openBox<T>(boxName);
      await box.clear();
    } catch (exception) {
      print(exception);
    } finally {
      if (Hive.isBoxOpen(boxName)) await Hive.close();
    }
  }
}
