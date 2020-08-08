import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_ticket_booking/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
String name;
String email;
String imageUrl;
Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  User _user = new User();
  _user.id = user.email;
  _user.name = user.displayName;
  _user.photoUrl = user.photoUrl;
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  return _user;
}

signOutGoogle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogged", false);
  await googleSignIn.signOut();
}
