import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/utils/sign_in.dart';
import 'package:movie_ticket_booking/models/booking.dart';
import 'package:ticket_pass_package/ticket_pass.dart';

class Ticket extends StatelessWidget {
  final Booking booking;
  Ticket({this.booking});
  @override
  Widget build(BuildContext context) {
    return TicketPass(
        alignment: Alignment.center,
        animationDuration: Duration(seconds: 1),
        height: 240,
        expandedHeight: 260,
        expansionChild: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              AppConstants.ticketPurchasedByText,
              style: TextStyle(color: Colors.black),
            ),
            Text(
              email,
              style: TextStyle(color: Colors.black),
            )
          ],
        )),
        expandIcon: CircleAvatar(
          backgroundColor: Colors.purple,
          maxRadius: 14,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 20,
          ),
        ),
        color: Colors.white,
        curve: Curves.easeOut,
        titleColor: Colors.grey,
        shrinkIcon: Align(
          alignment: Alignment.centerRight,
          child: CircleAvatar(
            maxRadius: 14,
            child: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        ticketTitle: Text(
          AppConstants.ticketTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        titleHeight: 50,
        width: 350,
        shadowColor: Colors.blue.withOpacity(0.5),
        elevation: 8,
        shouldExpand: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
          child: Container(
            height: 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppConstants.movieTime,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  booking.movieTime,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppConstants.movieName,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Text(
                                  booking.movieName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppConstants.ticketSeats,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              Text(
                                booking.seatNumbers.join(","),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                AppConstants.ticketPrice,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                              Text(
                                '\₹' + booking.cost.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
