import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/friend_controller.dart';
import 'package:todolist/utilities/auth.dart';
import 'package:todolist/utilities/myutils.dart';

import 'listuser.dart';

class FriendView extends StatefulWidget {
  FriendView({Key key}) : super(key: key);
  @override
  _FriendState createState() => new _FriendState();
}

class _FriendState extends StateMVC<FriendView> {
  _FriendState() : super(FriendController()) {
    cFriend = controller;
  }
  FriendController cFriend;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyScreens().initScreen(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend List'),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          width: MyScreens.sizeHorizontal * 100,
          child: StreamBuilder<QuerySnapshot>(
              stream: cFriend.getFriendLIst(AuthService.prefs.getString('uid')),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('No Friend List');
                List<Widget> listwidget = [];
                if (snapshot.data.docs.length > 0) {
                  snapshot.data.docs.forEach((element) {
                    listwidget.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0,
                                MyScreens.sizeVertical * 2,
                                MyScreens.sizeHorizontal * 5,
                                0),
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(element.data()['photoURL'])),
                          ),
                          Text(element.data()['displayName'])
                        ],
                      ),
                    );
                  });
                  return ListView(
                    shrinkWrap: true,
                    children: listwidget,
                  );
                } else {
                  return Container(
                    child: Center(child: Text('No Friend List')),
                  );
                }
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListUser();
            })).then((value) => setState(() {}));
          }),
    );
  }
}
