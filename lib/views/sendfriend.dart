import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/friend_controller.dart';
import 'package:todolist/utilities/auth.dart';
import 'package:todolist/utilities/myutils.dart';
import 'package:http/http.dart' as http;
import 'listuser.dart';

class SendFriend extends StatefulWidget {
  final docId;
  final category;
  final taskname;
  final reminder;
  final reminder_at;
  SendFriend(
      {Key key,
      this.docId,
      this.category,
      this.reminder,
      this.reminder_at,
      this.taskname})
      : super(key: key);
  @override
  _SendFriendState createState() => new _SendFriendState(
      docId: this.docId,
      category: this.category,
      reminder: this.reminder,
      reminder_at: this.reminder_at,
      taskname: this.taskname);
}

class _SendFriendState extends StateMVC<SendFriend> {
  final docId;
  final category;
  final taskname;
  final reminder;
  final reminder_at;
  _SendFriendState(
      {this.docId,
      this.category,
      this.reminder,
      this.reminder_at,
      this.taskname})
      : super(FriendController()) {
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
                    listwidget.add(InkWell(
                        onTap: () {
                          cFriend.setTaskToFriend(
                              uid: element.data()['fid'],
                              category: category,
                              taskname: taskname,
                              reminder: reminder,
                              reminder_at: reminder_at);
                          sendingmessage(element.data()['token'],
                              element.data()['displayName']);
                          Fluttertoast.showToast(msg: "Task Sent Successfuly");
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    MyScreens.sizeVertical * 2,
                                    MyScreens.sizeHorizontal * 5,
                                    0),
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        element.data()['photoURL'])),
                              ),
                              Text(element.data()['displayName'])
                            ],
                          ),
                        )));
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

  void sendingmessage(_token, _displayName) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAwQLk7Hs:APA91bGhtcCWcRaLmlwlCTdRwkvoq4UpTm0SISx-Ix8PlJc8tNAbH7rMGjBToefQBPbxuRX-19pOhjZ8I1FmyHYTPZAk0uQiz84zAe7Kw9E-5dd8JJOEu53TpDr-VNBjYuaGX8mBBlSp',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'You Get New Task From ' + _displayName,
            'title': 'To Do List'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': _token,
        },
      ),
    );
  }
}
