import 'package:flutter/material.dart';
import 'package:movie_ticket_booking/router.dart';
import 'package:movie_ticket_booking/dependency_injection.dart';
import 'package:movie_ticket_booking/screens/base_screen.dart';
import 'package:movie_ticket_booking/viewmodels/spalsh_view_model.dart';

void main() {
  AppInversionOfControl.configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<SplashScreenModel>(
        builder: (context, model, child) {
          return  MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        fontFamily: 'SourceSansPro',
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
    ); 
    });// define it once at root level.
  }
}
