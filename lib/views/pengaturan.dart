import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todolist/utilities/auth.dart';
import 'package:todolist/utilities/myutils.dart';
import 'package:todolist/views/friendview.dart';
import 'package:todolist/views/login.dart';

class PengaturanScreen extends StatelessWidget {
  PengaturanScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(child: PengaturanScreenBody()),
    );
  }
}

class PengaturanScreenBody extends StatefulWidget {
  @override
  _PengaturanScreenState createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreenBody> {
  _PengaturanScreenState({Key key});
  // @override
  // void initstate(){
  //   super.initState();
  // }
  // @override
  // void dispose(){

  // }
  @override
  Widget build(BuildContext context) {
    MyScreens().initScreen(context);
    return Container(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: MyScreens.safeVertical * 5,
              bottom: MyScreens.safeVertical * 5),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, MyScreens.sizeVertical * 2,
                    MyScreens.sizeHorizontal * 5, 0),
                child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(AuthService.prefs.getString("photoURL"))),
              ),
              SizedBox(
                height: MyScreens.safeVertical * 1,
              ),
              Container(
                  child: Text(AuthService.prefs.getString("displayName"))),
              Container(child: Text(AuthService.prefs.getString("email"))),
            ],
          ),
        ),
        Divider(
          color: Colors.black12,
          height: MyScreens.safeVertical * 0.4,
          thickness: MyScreens.safeVertical * 0.4,
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            child: Container(
                padding: EdgeInsets.only(
                    top: MyScreens.safeVertical * 2.5,
                    bottom: MyScreens.safeVertical * 2.5,
                    left: MyScreens.safeHorizontal * 8),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.userFriends),
                    Container(
                      margin:
                          EdgeInsets.only(left: MyScreens.safeHorizontal * 4),
                      child: Text(
                        'Daftar Teman',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: MyScreens.safeVertical * 2,
                        ),
                      ),
                    ),
                  ],
                )),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FriendView();
              }));
            },
          ),
        ),
        Divider(
          color: Colors.black12,
          height: MyScreens.safeVertical * 0.4,
          thickness: MyScreens.safeVertical * 0.4,
        ),
        Material(
          color: Colors.white,
          child: InkWell(
            child: Container(
                padding: EdgeInsets.only(
                    top: MyScreens.safeVertical * 2.5,
                    bottom: MyScreens.safeVertical * 2.5,
                    left: MyScreens.safeHorizontal * 8),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    FaIcon(FontAwesomeIcons.signOutAlt),
                    Container(
                      margin:
                          EdgeInsets.only(left: MyScreens.safeHorizontal * 4),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: MyScreens.safeVertical * 2,
                        ),
                      ),
                    ),
                  ],
                )),
            onTap: () {
              AuthService.googleSignIn.signOut().then((value) {
                AuthService.prefs.clear().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginViews()),
                  );
                });
              });
            },
          ),
        ),
        Divider(
          color: Colors.black12,
          height: MyScreens.safeVertical * 0.4,
          thickness: MyScreens.safeVertical * 0.4,
        ),
      ],
    ));
  }
}
