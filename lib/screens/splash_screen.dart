import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/appconstants.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';
import 'package:movie_ticket_booking/viewmodels/spalsh_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  userExists(SplashScreenModel model) async {
    await model.login();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SplashScreenModel>(onModelReady: (model) async {
      prefs = await SharedPreferences.getInstance();
      if (prefs.getBool("isLogged") != null && prefs.getBool("isLogged")) {
        userExists(model);
      }
    }, builder: (context, model, child) {
      return Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/icons/cinema.png", height: 120),
          SizedBox(
            height: 20,
          ),
          Text(
            AppConstants.splashTitle,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          model.user.id != null
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )
              : model.state == ViewState.Idle
                  ? OutlineButton(
                      onPressed: () async {
                        var isLoggedIn = await model.login();
                        if (isLoggedIn) {
                          prefs.setBool("isLogged", true);
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                  image: AssetImage(
                                      "assets/icons/google_logo.png"),
                                  height: 35.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  AppConstants.loginText,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          )),
                    )
                  : CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
        ],
      )));
    });
  }
}
