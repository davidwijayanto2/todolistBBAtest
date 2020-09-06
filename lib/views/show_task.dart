import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/views/home.dart';
import 'package:intl/intl.dart';
import 'package:todolist/views/sendfriend.dart';
import '../utilities/util.dart';
import 'edit_task.dart';

class ShowTask {
  final docId;
  ShowTask({this.docId});
  mainBottomSheet(BuildContext context) {
    print('masuktask');
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ShowTaskWidget(
          context: context,
          docId: this.docId,
        );
      },
    );
  }
}

class ShowTaskWidget extends StatefulWidget {
  final context;
  final docId;
  ShowTaskWidget({this.context, this.docId});
  _ShowTaskState createState() =>
      _ShowTaskState(context: this.context, docId: this.docId);
}

class _ShowTaskState extends StateMVC<ShowTaskWidget> {
  _ShowTaskState({this.context, this.docId}) : super(TaskController()) {
    cTask = controller;
  }
  TaskController cTask;
  BuildContext context;
  final docId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: cTask.getSingleTask(docId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var docData = snapshot.data;
            //print('mes: ' + docData.data()['taskname']);

            return Container(
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Positioned(
                    top: MediaQuery.of(context).size.height / 25,
                    left: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(175, 30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.of(context).size.height / 2 - 340,
                      child: Container(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child:
                                  Image.asset('assets/images/fab-delete.png'),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    CustomColors.PurpleLight,
                                    CustomColors.PurpleDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.PurpleShadow,
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(mainAxisSize: MainAxisSize.min, children: <
                              Widget>[
                            SizedBox(height: 10),
                            Text(
                              'Detail task',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Text(docData.data()['taskname'])),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1.0,
                                    color: CustomColors.GreyBorder,
                                  ),
                                  bottom: BorderSide(
                                    width: 1.0,
                                    color: CustomColors.GreyBorder,
                                  ),
                                ),
                              ),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: <Widget>[
                                  (docData.data()['category'] != 'Personal')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CustomColors.YellowAccent,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Personal'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Personal',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: CustomColors.YellowAccent,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      CustomColors.GreenShadow,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  (docData.data()['category'] != 'Work')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color: CustomColors.GreenIcon,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Work'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Work',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: CustomColors.GreenIcon,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      CustomColors.GreenShadow,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  (docData.data()['category'] != 'Meeting')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CustomColors.PurpleIcon,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Meeting'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Meeting',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: CustomColors.PurpleIcon,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      CustomColors.PurpleShadow,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  (docData.data()['category'] != 'Study')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color: CustomColors.BlueIcon,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Study'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Study',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: CustomColors.BlueIcon,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      CustomColors.BlueShadow,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  (docData.data()['category'] != 'Shopping')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color:
                                                      CustomColors.OrangeIcon,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Shopping'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Shopping',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color: CustomColors.OrangeIcon,
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      CustomColors.YellowShadow,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  (docData.data()['category'] != 'Party')
                                      ? Center(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 10.0,
                                                width: 10.0,
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  color: CustomColors
                                                      .DeeppurlpleIcon,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Text('Party'),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            child: Text(
                                              'Party',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              color:
                                                  CustomColors.DeeppurlpleIcon,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: CustomColors
                                                      .PurpleBackground,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 3.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Text(
                                    'Reminder date',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        DateFormat('dd MMM yyyy, hh:mm a')
                                            .format(DateTime.parse(docData
                                                .data()['reminder_at']
                                                .toDate()
                                                .toString())),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ]),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Checkbox(
                                  value: (docData.data()['reminder'] == 0)
                                      ? false
                                      : true,
                                  onChanged: (bool value) {},
                                ),
                                Text('Reminder'),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              EditTask(docId: docId).mainBottomSheet(context);
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    CustomColors.BlueLight,
                                    CustomColors.BlueDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.BlueShadow,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Center(
                                child: const Text(
                                  'Edit task',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SendFriend(
                                        docId: docId,
                                        category: docData.data()['category'],
                                        taskname: docData.data()['taskname'],
                                        reminder: docData.data()['reminder'],
                                        reminder_at:
                                            docData.data()['reminder_at'])),
                              ).then((value) {
                                if (value != null) {
                                  Navigator.pop(context);
                                }
                              });

                              // Navigator.pop(context);
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 60,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    CustomColors.BlueLight,
                                    CustomColors.BlueDark,
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.BlueShadow,
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Center(
                                child: const Text(
                                  'Share Task',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )))
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
