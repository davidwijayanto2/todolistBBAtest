import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/controller/login_controller.dart';
import 'package:todolist/utilities/auth.dart';
import "package:http/http.dart" as http;
import 'dart:convert' show json;
import 'package:todolist/views/empty.dart';
import 'package:todolist/views/home.dart';
import '../utilities/util.dart';

class LoginViews extends StatefulWidget {
  LoginViews({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends StateMVC<LoginViews> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _currentUser;
  _LoginState() : super(LoginController()) {
    cLogin = controller;
  }
  LoginController cLogin;
  @override
  void initState() {
    super.initState();
    AuthService.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
    AuthService.googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _login() async {
    try {
      await AuthService.googleSignIn.signIn();
      setState(() {
        _currentUser = AuthService.googleSignIn.currentUser;
        print(
            "displayname: " + AuthService.googleSignIn.currentUser.displayName);
        var result = cLogin.setUserData(
            uid: _currentUser.id,
            email: _currentUser.email,
            photoURL: _currentUser.photoUrl,
            displayName: _currentUser.displayName,
            fbtoken: AuthService.token);
        if (result) {
          _isLoggedIn = true;
          _setlocaldata();
          Fluttertoast.showToast(msg: "Login Berhasil");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          Fluttertoast.showToast(msg: "Terjadi kesalahan saat login.");
        }
      });
    } catch (err) {
      print(err);
    }
  }

  _setlocaldata() async {
    AuthService.prefs.setString("uid", _currentUser.id);
    AuthService.prefs.setString("email", _currentUser.email);
    AuthService.prefs.setString("photoURL", _currentUser.photoUrl);
    AuthService.prefs.setString("displayName", _currentUser.displayName);
  }
  // Future<void> _handleGetContact() async {
  //   final http.Response response = await http.get(
  //     'https://people.googleapis.com/v1/people/me/connections'
  //     '?requestMask.includeField=person.names',
  //     headers: await _currentUser.authHeaders,
  //   );
  //   if (response.statusCode != 200) {
  //     print('People API ${response.statusCode} response: ${response.body}');
  //     return;
  //   }
  //   final Map<String, dynamic> data = json.decode(response.body);
  //   //final String namedContact = _pickFirstNamedContact(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  _login();
                },
              )
            ]),
      )),
    );
  }
}
