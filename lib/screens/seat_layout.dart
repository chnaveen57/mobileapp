import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/utils/sign_in.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:movie_ticket_booking/models/seatlayout.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/widgets/curve_screen.dart';
import 'package:movie_ticket_booking/viewmodels/seat_layout_view_model.dart';

class SeatLayOut extends StatefulWidget {
  final SeatLayoutModel seatLayoutModel;
  SeatLayOut({this.seatLayoutModel});

  @override
  _SeatLayOutState createState() => _SeatLayOutState();
}

class _SeatLayOutState extends State<SeatLayOut> {
  bool isSeatSelected = false;
  Map<int, String> selectedSeats = new Map<int, String>();
  List<String> seat;
  int seatCount;
  getseatNames() {
    List<String> selectedSeatNames = selectedSeats.values.toList();
    return selectedSeatNames.join(",");
  }

  getBookNowWidget(SeatLayoutViewModel model) {
    return Container(
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.purple],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(getseatNames()),
                    Text(AppConstants.cost +
                        ((widget.seatLayoutModel.seat.cost) *
                                selectedSeats.length)
                            .toString()),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 20),
              child: RaisedButton(
                textColor: Colors.black,
                color: Colors.white,
                child: Text(
                  AppConstants.book,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                onPressed: () async {
                  model.updateIsBooking(true);
                  selectedSeats.forEach((key, value) {
                    widget.seatLayoutModel.seat.seatsList[key] = "1";
                    seat[key] = "1";
                  });
                  Booking booking = new Booking(
                    cost:
                        selectedSeats.length * widget.seatLayoutModel.seat.cost,
                    movieName: widget.seatLayoutModel.movieName,
                    movieTime: widget.seatLayoutModel.seat.date +
                        "," +
                        widget.seatLayoutModel.seat.timeSlot,
                    seatID: widget.seatLayoutModel.seat.id,
                    seatNumbers: selectedSeats.values.toList(),
                    userId: email,
                    id: DateTime.now().toString(),
                  );
                  var isUpdated =
                      await model.setSeats(widget.seatLayoutModel.seat);
                  if (isUpdated) {
                    var _isbooked = await model.postBooking(booking);
                    if (_isbooked) {
                      model.updateIsBooking(false);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content:
                                new Text(AppConstants.bookingSucessfulMessage),
                          );
                        },
                      );
                      await Future.delayed(Duration(milliseconds: 900), () {
                        Navigator.of(context).pop();
                      });

                      Navigator.popAndPushNamed(context, '/bookings');
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: new Text(AppConstants.bookingFailureMessage),
                        );
                      },
                    );
                  }
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ));
  }

  getColor(String value) {
    if (value == "0") return Colors.grey;
    if (value == "1") return Colors.blueGrey[700];
    if (value == "2") return Colors.purple[300];
  }

  Widget showSeatNumber(int index, SeatLayoutViewModel model) {
    return GestureDetector(
      onTap: () {
        if (seatCount > index + 1) {
          seat = new List<String>.from(widget.seatLayoutModel.seat.seatsList);
          selectedSeats.clear();
          model.onChange();
        }
        seatCount = index + 1;
        model.onChange();
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: seatCount == index + 1 ? Colors.purple : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 18,
        width: 18,
        child: Text((index + 1).toString()),
      ),
    );
  }

  changeSeatNumberDialog(SeatLayoutViewModel model) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)), //this right here
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.circular(30)),
                height: 150,
                padding: EdgeInsets.only(left: 20, top: 40, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(AppConstants.changeSeatCapacity),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6),
                      itemBuilder: (context, index) {
                        return showSeatNumber(index, model);
                      },
                      itemCount: 6,
                    ),
                  ],
                )),
          );
        });
  }

  getSeatWidget(int index, SeatLayoutViewModel model) {
    int seatNameindex = index ~/ 10;
    int number = index - seatNameindex * 10 + 1;
    return GestureDetector(
      onTap: () {
        if (seat[index] == "2") {
          selectedSeats.remove(index);
          seat[index] = "0";
          model.onChange();
        } else {
          if (seat[index] != "1" && selectedSeats.length < seatCount) {
            int requiredSeats = seatCount - selectedSeats.length;
            for (int _index = 0; _index < requiredSeats; _index++) {
              seatNameindex = (index + _index) ~/ 10;
              number = (index + _index) - seatNameindex * 10 + 1;
              selectedSeats[index + _index] =
                  model.seatNames[seatNameindex] + number.toString();
              seat[index + _index] = "2";
            }
            model.onChange();
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: new Text("An user can only book " +
                      '$seatCount' +
                      " tickets at a time"),
                );
              },
            );
          }
        }
      },
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: getColor(seat[index])),
        alignment: Alignment.center,
        child: Text(model.seatNames[seatNameindex] + number.toString()),
      ),
    );
  }

  Widget build(BuildContext context) {
    return BaseScreen<SeatLayoutViewModel>(onModelReady: (model) {
      model.networkStatus();
      seatCount = widget.seatLayoutModel.seatCount;
      seat = new List<String>.from(widget.seatLayoutModel.seat.seatsList);
    }, builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(AppConstants.selectSeat),
          ),
          body: model.isConnected ? !(model.isbooking)
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        changeSeatNumberDialog(model);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pink, Colors.purple],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Text(
                          AppConstants.changeSeatCapacity,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 10),
                        itemBuilder: (context, index) {
                          return getSeatWidget(index, model);
                        },
                        itemCount: widget.seatLayoutModel.seat.seatsList.length,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(AppConstants.seatSelected),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: Colors.purple[300]),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(AppConstants.seatBooked),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: Colors.blueGrey[700]),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(AppConstants.availableSeats),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    selectedSeats.length != 0
                        ? getBookNowWidget(model)
                        : SizedBox(),
                    Spacer(),
                    AspectRatio(
                      aspectRatio: 320 / 41,
                      child: CustomPaint(
                        painter: CurveScreenPainter(),
                      ),
                    ),
                    Text(
                      AppConstants.screenHere,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      CircularProgressIndicator(),
                      Text(
                        AppConstants.booking,
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer()
                    ],
                  ),
                ):Center(child: Text("No Internet Connetion"),));
    });
  }
}
