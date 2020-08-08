import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/models/movie.dart';
import 'package:movie_ticket_booking/models/moviebooking.dart';
import 'package:movie_ticket_booking/models/theater.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/movie_card_view_model.dart';

class MovieCard extends StatefulWidget {
  MovieCard({this.movie, this.isReleased, this.theaters});
  final Movie movie;
  final bool isReleased;
  final List<Theater> theaters;

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  Widget build(BuildContext context) {
    return BaseScreen<MovieCardViewModel>(
        onModelReady: (model) async{
          await model.getImage(widget.movie.imageUrl);
        },
        builder: (context, model, child) {
          return Container(
              decoration: new BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(15),
                image: model.imageData!=null ? DecorationImage(
                  image:model.imageData,
                  fit: BoxFit.fill,
                ):null,
              ),
              width: 200,
              margin: EdgeInsets.only(right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Text(
                            widget.movie.name,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(widget.isReleased ? widget.movie.runTime : widget.movie.releaseDate,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ClipOval(
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.pink, Colors.purple],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            height: 45,
                            width: 45,
                            child: RaisedButton(
                              color: Colors.transparent,
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 20,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                var moviebooking = new MovieBookingModel(
                                    movie: widget.movie,
                                    isReleased: widget.isReleased,
                                    theaters: widget.theaters);
                                Navigator.pushNamed(context, '/moviebooking',
                                    arguments: moviebooking);
                              },
                            )),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
