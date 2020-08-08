import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/models/moviebooking.dart';
import 'package:movie_ticket_booking/models/seat.dart';
import 'package:movie_ticket_booking/models/seatlayout.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
import 'package:movie_ticket_booking/viewmodels/movie_booking_view_model.dart';
import 'package:movie_ticket_booking/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';

class MovieBooking extends StatefulWidget {
  final MovieBookingModel movieBookingModel;
  MovieBooking({this.movieBookingModel});
  @override
  _MovieBookingState createState() => _MovieBookingState();
}

class _MovieBookingState extends State<MovieBooking> {
  String firstHalf;
  String secondHalf;
  bool flag = true;
  DateTime changedDate;

  Widget showSeatNumber(int index, Seat seat) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        var seatLayoutModel = new SeatLayoutModel(
            seat: seat,
            seatCount: index + 1,
            movieName: widget.movieBookingModel.movie.name);
        Navigator.pushNamed(context, '/seatlayout', arguments: seatLayoutModel);
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 18,
        width: 18,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void seatsDailog(Seat seat) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)), //this right here
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.circular(30.0)),
                height: 150,
                padding: EdgeInsets.only(left: 20, top: 40, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(AppConstants.selectSeatDialogTitle),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6),
                      itemBuilder: (context, index) {
                        return showSeatNumber(index, seat);
                      },
                      itemCount: 6,
                    ),
                  ],
                )),
          );
        });
  }

  getSeats(MovieBookingViewModel model) async {
    await model.getSeats(
        widget.movieBookingModel.movie, widget.movieBookingModel.theaters);
    if (widget.movieBookingModel.movie.story.length > 250) {
      firstHalf = widget.movieBookingModel.movie.story.substring(0, 250);
      secondHalf = widget.movieBookingModel.movie.story
          .substring(250, widget.movieBookingModel.movie.story.length);
    } else {
      firstHalf = widget.movieBookingModel.movie.story;
      secondHalf = "";
    }
    if (widget.movieBookingModel.isReleased) {
      onDaySelected(DateTime.now(), model);
    } else {
      onDaySelected(widget.movieBookingModel.movie.startingDate, model);
    }
  }

  getValidity(String timeSlot) {
    var time = DateTime.now();
    String selectedDate = DateFormat("yyyy-MM-dd").format(changedDate);
    var showTime =
        DateFormat("yyyy-MM-dd hh:mm").parse(selectedDate + " " + timeSlot);
    if (showTime.difference(time).inMinutes < 30 || showTime.difference(time).isNegative) {
      return false;
    } else {
      return true;
    }
  }

  onDaySelected(DateTime _date, MovieBookingViewModel model) {
    model.clearData();
    changedDate = _date;
    model.seats.forEach((key, value) {
      List<Seat> _seats = new List();
      for (var seat in value) {
        if (DateFormat("yyyy-MM-dd").format(_date) == seat.date) {
          _seats.add(seat);
        }
        if (_seats.length != 0) {
          _seats.sort((a, b) {
            var adate = a.date;
            var bdate = b.date;
            return DateFormat("yyyy-MM-dd hh:mm")
                .parse(adate + " " + a.timeSlot)
                .compareTo(DateFormat("yyyy-MM-dd hh:mm")
                    .parse(bdate + " " + b.timeSlot));
          });
          model.setFilteredTheaterSeats(_seats, key);
        }
      }
    });
    if (model.filteredTheaterSeats != null &&
        model.filteredTheaterSeats.length > 0)
      model.setFilteredTheaters(model.filteredTheaterSeats.keys.toList());
    else
      model.onChange();
  }

  Widget build(BuildContext context) {
    return BaseScreen<MovieBookingViewModel>(onModelReady: (model) {
      getSeats(model);
      changedDate = new DateTime.now();
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: CustomAppBar(
                  movie: widget.movieBookingModel.movie,
                  model: model,
                  notifyParent: onDaySelected,
                  isReleased: widget.movieBookingModel.isReleased,
                ),
              ),
              body: model.viewState == ViewState.Idle &&
                      widget.movieBookingModel.movie != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                AppConstants.story,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            secondHalf.isEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      firstHalf,
                                    ))
                                : Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(flag
                                            ? (firstHalf + " ...")
                                            : (firstHalf + secondHalf)),
                                        GestureDetector(
                                          child: Text(
                                            flag
                                                ? AppConstants.readmore
                                                : AppConstants.readless,
                                            style: TextStyle(
                                                color: Colors.purple[300]),
                                          ),
                                          onTap: () {
                                            flag = !flag;
                                            model.onChange();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                AppConstants.cast,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                height: 120,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                        .movieBookingModel.movie.actors.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: AssetImage(
                                                    "assets/images/profile.png"),
                                                radius: 30),
                                            SizedBox(height: 12),
                                            Text(widget.movieBookingModel.movie
                                                .actors[index]),
                                          ],
                                        ),
                                      );
                                    })),
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                AppConstants.nowshowingTheatersTitle,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            model.filteredTheaterSeats != null &&
                                    model.filteredTheaterSeats.length > 0
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.theaterSeats.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            model.filteredTheaters[index].name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Text(
                                              AppConstants.showselectTitle,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                              height: 40,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: model
                                                      .filteredTheaterSeats[
                                                          model.filteredTheaters[
                                                              index]]
                                                      .length,
                                                  itemBuilder:
                                                      (context, subindex) {
                                                    return GestureDetector(
                                                      onTapUp: (TapUpDetails
                                                          details) {
                                                        if (getValidity(model
                                                            .filteredTheaterSeats[
                                                                model.filteredTheaters[
                                                                    index]]
                                                                [subindex]
                                                            .timeSlot)) {
                                                          seatsDailog(model
                                                              .filteredTheaterSeats[model
                                                                  .filteredTheaters[
                                                              index]][subindex]);
                                                        }
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 75,
                                                          height: 10,
                                                          decoration: getValidity(model
                                                                  .filteredTheaterSeats[
                                                                      model.filteredTheaters[
                                                                          index]]
                                                                      [subindex]
                                                                  .timeSlot)
                                                              ? BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Colors
                                                                          .pink,
                                                                      Colors
                                                                          .purple
                                                                    ],
                                                                    begin: Alignment
                                                                        .centerLeft,
                                                                    end: Alignment
                                                                        .centerRight,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10))
                                                              : BoxDecoration(
                                                                  color: Colors
                                                                      .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                          child: Text(model
                                                              .filteredTheaterSeats[
                                                                  model.filteredTheaters[
                                                                      index]]
                                                                  [subindex]
                                                              .timeSlot),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      );
                                    })
                                : Center(
                                    child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/notavailable.png",
                                        height: 100,
                                      ),
                                      Text(
                                        AppConstants.noShowAvailable,
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  )),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )));
    });
  }
}
