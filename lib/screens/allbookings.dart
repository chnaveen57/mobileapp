import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
import 'package:movie_ticket_booking/viewmodels/booking_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/spalsh_view_model.dart';
import 'package:movie_ticket_booking/widgets/ticket.dart';
import 'package:movie_ticket_booking/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class AllBookings extends StatefulWidget {
  @override
  _AllBookingsState createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  Widget build(BuildContext context) {
    return BaseScreen<BookingViewModel>(onModelReady: (model) {
      model.getBookings(Provider.of<SplashScreenModel>(context).user.id);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            AppConstants.bookingsAppbarTitle,
            style: TextStyle(fontSize: 20),
          ),
        ),
        drawer: CustomDrawer(),
        body: !(model.viewState == ViewState.Busy)
            ? model.bookings.length != 0
                ? Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.all(20),
                            child: Ticket(
                              booking: model.bookings[index],
                            ));
                      },
                      itemCount: model.bookings.length,
                    ),
                  )
                : Center(
                    child: Text(AppConstants.noBookings),
                  )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}
