import 'package:movie_ticket_booking/utils/sign_in.dart';
import 'package:movie_ticket_booking/models/user.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';

class SplashScreenModel extends BaseModel {
  static User _user = new User();
  User get user => _user;
  Future<bool> login() async {
    changeState(ViewState.Busy);
    _user = await signInWithGoogle();
    changeState(ViewState.Idle);
    return (_user != null);
  }

  void logout() async {
    changeState(ViewState.Busy);
    await signOutGoogle();
    _user = new User();
    changeState(ViewState.Idle);
  }
}
