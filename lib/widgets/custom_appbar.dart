import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/movie_booking_view_model.dart';
import 'package:movie_ticket_booking/viewmodels/movie_card_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Movie movie;
  final Function(DateTime time, MovieBookingViewModel model) notifyParent;
  final bool isReleased;
  final model;
  CustomAppBar(
      {Key key, this.movie, this.notifyParent, this.isReleased, this.model})
      : preferredSize = Size.fromHeight(70),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  CalendarController _calendarController = new CalendarController();
  @override
  Widget build(BuildContext context) {
    return BaseScreen<MovieCardViewModel>(onModelReady: (model) async {
      await model.getImage(widget.movie.posterUrl);
    }, builder: (context, model, child) {
      return AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            image: model.imageData!=null ? new DecorationImage(
              image:  model.imageData,
              fit: BoxFit.fill,
            ):null
          ),
          child: Padding(
              padding: EdgeInsets.only(top: 40, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.movie.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.movie.runTime,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.movie.genre.join(","),
                    style: TextStyle(fontSize: 20),
                  ),
                  TableCalendar(
                      initialSelectedDay: widget.isReleased
                          ? DateTime.now()
                          : widget.movie.startingDate,
                      startDay: DateTime.now(),
                      endDay: widget.movie.endingDate,
                      calendarController: _calendarController,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      initialCalendarFormat: CalendarFormat.week,
                      calendarStyle:
                          CalendarStyle(todayColor: Colors.transparent),
                      headerVisible: false,
                      onDaySelected: (DateTime time, List<dynamic> events) {
                        widget.notifyParent(time, widget.model);
                      }),
                ],
              )),
        ),
      );
    });
  }
}
