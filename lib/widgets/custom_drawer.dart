import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/extensions/string.dart';
import 'package:movie_ticket_booking/models/user.dart';
import 'package:movie_ticket_booking/screens/home.dart';
import 'package:movie_ticket_booking/viewmodels/spalsh_view_model.dart';
import 'package:movie_ticket_booking/widgets/drawer_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final Function() notifyParent;
  CustomDrawer({Key key, this.notifyParent}) : super(key: key);
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User user;
  SplashScreenModel usermodel;
  SharedPreferences prefs;

  Widget build(BuildContext context) {
    usermodel = Provider.of<SplashScreenModel>(context);
    user = usermodel.user;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150.0,
            child: DrawerHeader(
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.network(
                      user.photoUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      user.name.captialCamelCase,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: DrawerItem(
              icon: Icons.home,
              name: AppConstants.homeTitle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          GestureDetector(
            child: DrawerItem(
              icon: Icons.clear_all,
              name: AppConstants.bookingsTitle,
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/bookings');
            },
          ),
          GestureDetector(
            child: DrawerItem(
              icon: Icons.exit_to_app,
              name: AppConstants.logout,
            ),
            onTap: () async {
              prefs = await SharedPreferences.getInstance();
              prefs.setBool("isLogged", false);
              usermodel.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
