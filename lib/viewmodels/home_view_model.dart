import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/hive/hive_constants.dart';
import 'package:movie_ticket_booking/hive/hive_db_intialization.dart';
import 'package:movie_ticket_booking/models/location.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/services/contracts/location_contract.dart';
import 'package:movie_ticket_booking/services/contracts/movie_contract.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
class HomeViewModel extends BaseModel {
  LocationContract _locationContract;
  MovieContract _movieContract;
  HiveDB _hiveDB;
  NetworkInfo _networkInfo;
  HomeViewModel(this._movieContract, this._locationContract, this._networkInfo,
      this._hiveDB);
  List<Location> _locations = new List<Location>();
  List<Movie> _nowShowing = new List<Movie>();
  List<Movie> _comingSoon = new List<Movie>();
  List<Theater> _theaters = new List<Theater>();
  Location _currentLocation = new Location();
  dynamic _movies;
  List<Location> get locations => _locations;
  Location get currentLocation => _currentLocation;
  List<Movie> get nowshowingMovies => _nowShowing;
  List<Movie> get comingsoonMovies => _comingSoon;
  List<Theater> get theaters => _theaters;
  dynamic get movies => _movies;
  void setCurrentLocation(Location location) {
    _currentLocation = location;
  }

  onChange() {
    notifyListeners();
  }
  Future<void> getMovies() async {
    changeState(ViewState.Busy);
    if (await _networkInfo.isConnected) {
      _locations = await _locationContract.getLocations();
      await _hiveDB.clearAll(HiveDBConstants.locationBox);
      await _hiveDB.addAll(HiveDBConstants.locationBox, _locations);
    } else {
      _locations = await _hiveDB.getAll<Location>(HiveDBConstants.locationBox);
    }
    if (_currentLocation.id == null) {
      _currentLocation = _locations[0];
    }
    if (await _networkInfo.isConnected) {
      _movies = await _movieContract.getMoviesByLocation(_currentLocation.id);
      _nowShowing = movies[0];
      _comingSoon = movies[1];
      _theaters = movies[2];
      await _hiveDB.clearAll(HiveDBConstants.nowShowingMovies);
      await _hiveDB.clearAll(HiveDBConstants.upComingMoviesBox);
      await _hiveDB.clearAll(HiveDBConstants.theatersBox);
      await _hiveDB.addAll(HiveDBConstants.nowShowingMovies, _nowShowing);
      await _hiveDB.addAll(HiveDBConstants.upComingMoviesBox, _comingSoon);
      await _hiveDB.addAll(HiveDBConstants.theatersBox, _theaters);
    } else {
      _nowShowing =
          await _hiveDB.getAll<Movie>(HiveDBConstants.nowShowingMovies);
      _comingSoon =
          await _hiveDB.getAll<Movie>(HiveDBConstants.upComingMoviesBox);
      _theaters = await _hiveDB.getAll<Theater>(HiveDBConstants.theatersBox);
    }
    changeState(ViewState.Idle);
  }
}
