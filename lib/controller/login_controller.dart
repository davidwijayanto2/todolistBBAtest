import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/models/users.dart';

class LoginController extends ControllerMVC {
  LoginController([StateMVC state]) : super(state) {
    user = Users();
  }
  Users user;

  bool setUserData({uid, email, photoURL, displayName, fbtoken}) {
    Users _user = new Users(
        uid: uid,
        email: email,
        photoURL: photoURL,
        displayName: displayName,
        fbtoken: fbtoken);
    var result = user.setUserData(_user);
    return result;
  }
}
