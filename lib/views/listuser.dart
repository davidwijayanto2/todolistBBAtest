import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/friend_controller.dart';
import 'package:todolist/utilities/auth.dart';
import 'package:todolist/utilities/myutils.dart';

class ListUser extends StatefulWidget {
  ListUser({Key key}) : super(key: key);
  @override
  _ListUserState createState() => new _ListUserState();
}

class _ListUserState extends StateMVC<ListUser> {
  _ListUserState() : super(FriendController()) {
    cFriend = controller;
  }
  FriendController cFriend;
  var stream;
  final txtsearch = TextEditingController();
  @override
  void initState() {
    super.initState();
    stream = cFriend.getUser(AuthService.prefs.getString('uid'));
  }

  @override
  Widget build(BuildContext context) {
    MyScreens().initScreen(context);
    return Scaffold(
      body: Column(children: [
        Container(
            child: Row(
          children: <Widget>[
            Flexible(
              child: TextFormField(
                controller: txtsearch,
                decoration: InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  stream = cFriend.getSearchUser(txtsearch.text.trim());
                });
              },
            )
          ],
        )),
        StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('No User List');
              List<Widget> listwidget = [];
              if (snapshot.data.docs.length > 0) {
                snapshot.data.docs.forEach((element) {
                  if (AuthService.prefs.getString('uid') !=
                      element.data()['uid'])
                    listwidget.add(Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            var result = cFriend.setFriend(
                              fid: element.data()['uid'],
                              uid: AuthService.prefs.getString('uid'),
                              displayName: element.data()['displayName'],
                              photoURL: element.data()['photoURL'],
                              email: element.data()['email'],
                              fbtoken: element.data()['fbtoken'],
                            );
                            if (result) {
                              Fluttertoast.showToast(
                                  msg: "Successfully Adding a Friend");
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ));
                });
                return ListView(
                  shrinkWrap: true,
                  children: listwidget,
                );
              } else {
                return Container(
                  child: Center(child: Text('No User List')),
                );
              }
            })
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ListUser();
            }));
          }),
    );
  }
}
