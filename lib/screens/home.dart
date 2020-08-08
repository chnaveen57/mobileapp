import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/models/location.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
import 'package:movie_ticket_booking/viewmodels/home_view_model.dart';
import 'package:movie_ticket_booking/widgets/custom_drawer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_ticket_booking/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<AutoCompleteTextFieldState<Location>> key = new GlobalKey();
  TextEditingController locationController = new TextEditingController();
  Widget build(BuildContext context) {
    return BaseScreen<HomeViewModel>(
        onModelReady: (model) => model.getMovies(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppConstants.homeAppbarTitle,
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    showLocationDailog(context, model);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 30,
                        ),
                        Text(
                          model.currentLocation.name != null
                              ? '${model.currentLocation.name}'
                              : "",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 160,
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.pink, Colors.purple],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Center(
                            child: Text(
                              AppConstants.nowShowing,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.38,
                      child: 
                              model.state == ViewState.Idle
                          ? model.nowshowingMovies.length != 0
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.nowshowingMovies.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: MovieCard(
                                        movie: model.nowshowingMovies[index],
                                        isReleased: true,
                                        theaters: model.theaters,
                                      ),
                                    );
                                  })
                              : Center(
                                  child: Text(
                                  "No Movies",
                                  style: TextStyle(fontSize: 20),
                                ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey[500],
                                      highlightColor: Colors.white,
                                      child: Container(
                                        color: Colors.white,
                                        margin:
                                            EdgeInsets.only(right: 10, top: 10),
                                        width: 200,
                                      )),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    model.comingsoonMovies.length != 0
                        ? Text(
                            AppConstants.comingsoon,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        : SizedBox(),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.38,
                      child: model.comingsoonMovies != null &&
                              model.state == ViewState.Idle
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: model.comingsoonMovies.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: MovieCard(
                                    movie: model.comingsoonMovies[index],
                                    isReleased: false,
                                    theaters: model.theaters,
                                  ),
                                );
                              })
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey[400],
                                      highlightColor: Colors.white,
                                      child: Container(
                                        color: Colors.white,
                                        margin:
                                            EdgeInsets.only(right: 10, top: 10),
                                        width: 200,
                                      )),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: CustomDrawer(),
          );
        });
  }

  showLocationDailog(BuildContext context, HomeViewModel model) async {
    Location _location;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: AutoCompleteTextField<Location>(
                      clearOnSubmit: false,
                      controller: locationController,
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                      decoration: new InputDecoration(
                          hintText: AppConstants.locationhint,
                          hintStyle: TextStyle(color: Colors.black)),
                      itemSubmitted: (item) {
                        locationController.text = item.name;
                        _location = item;
                        model.onChange();
                      },
                      key: key,
                      suggestions: model.locations,
                      itemBuilder: (context, item) {
                        return Text(
                          item.name,
                          style: TextStyle(fontSize: 20.0),
                        );
                      },
                      itemSorter: (a, b) {
                        return a.name.compareTo(b.name);
                      },
                      itemFilter: (item, query) {
                        return item.name
                            .toLowerCase()
                            .startsWith(query.toLowerCase());
                      }),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text(AppConstants.cancelbuttoonText),
                  onPressed: () {
                    locationController.clear();
                    model.onChange();
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: Text(AppConstants.savebuttonText),
                  onPressed: () async {
                    locationController.clear();
                    model.setCurrentLocation(_location);
                    model.getMovies();
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
