import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );
  static FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  static SharedPreferences prefs;
  static var token;
}
