import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utilities/myutils.dart';
import 'package:todolist/views/app_bars.dart';
import 'package:todolist/views/bottom_navigation.dart';
import 'package:todolist/views/fab.dart';
import 'package:todolist/utilities/util.dart';
import 'package:todolist/views/show_task.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  final bottomNavigationBarIndex = 0;
  _HomeState() : super(TaskController()) {
    cTask = controller;
  }
  TaskController cTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<QuerySnapshot>(
            stream: cTask.getAllTask(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Column(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Hero(
                        tag: 'Clipboard',
                        child: Image.asset('assets/images/Clipboard-empty.png'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'No tasks',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.TextHeader),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'You have no tasks to do.',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: CustomColors.TextBody,
                                fontFamily: 'opensans'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                );

              if (snapshot.data.docs.length > 0) {
                //print('masuk 2');
                List<Widget> listwidget = [];
                var dateflag = 0;
                snapshot.data.docs.forEach((element) {
                  //print('tes:' + element.get('taskname'));
                  var reminder_at = DateTime.parse(
                      element.get('reminder_at').toDate().toString());
                  var tomorrow = DateTime.parse(
                          DateFormat('yyyy-MM-dd 23:59:59')
                              .format(DateTime.now().add(Duration(days: 1))))
                      .day;
                  if (dateflag != reminder_at.day) {
                    if (reminder_at.day == DateTime.now().day) {
                      listwidget.add(
                        Container(
                          margin:
                              EdgeInsets.only(top: 15, left: 20, bottom: 15),
                          child: Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.TextSubHeader),
                          ),
                        ),
                      );
                    } else if (reminder_at.day == tomorrow) {
                      listwidget.add(
                        Container(
                          margin:
                              EdgeInsets.only(top: 15, left: 20, bottom: 15),
                          child: Text(
                            'Tomorrow',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.TextSubHeader),
                          ),
                        ),
                      );
                    } else {
                      listwidget.add(
                        Container(
                          margin:
                              EdgeInsets.only(top: 15, left: 20, bottom: 15),
                          child: Text(
                            DateFormat('dd MMM yyyy').format(reminder_at),
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.TextSubHeader),
                          ),
                        ),
                      );
                    }
                    if (reminder_at.isBefore(DateTime.now())) {
                      listwidget.add(
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                          padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset('assets/images/checked.png'),
                              Text(
                                DateFormat('hh.mm a').format(reminder_at),
                                style: TextStyle(color: CustomColors.TextGrey),
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  element.get('taskname'),
                                  style: TextStyle(
                                      color: CustomColors.TextGrey,
                                      //fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              (element.get('reminder') == 0)
                                  ? Image.asset('assets/images/bell-small.png')
                                  : Image.asset(
                                      'assets/images/bell-small-yellow.png'),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.015, 0.015],
                              colors: [
                                MyUtils.getCategoryColor(
                                    element.get('category')),
                                Colors.white
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.GreyBorder,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      listwidget.add(
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: InkWell(
                            onTap: () {
                              print('tap');
                              ShowTask(docId: element.id)
                                  .mainBottomSheet(context);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                              padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                      'assets/images/checked-empty.png'),
                                  Text(
                                    DateFormat('hh.mm a').format(reminder_at),
                                    style:
                                        TextStyle(color: CustomColors.TextGrey),
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      element.get('taskname'),
                                      style: TextStyle(
                                          color: CustomColors.TextHeader,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  (element.get('reminder') == 0)
                                      ? Image.asset(
                                          'assets/images/bell-small.png')
                                      : Image.asset(
                                          'assets/images/bell-small-yellow.png'),
                                ],
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  stops: [0.015, 0.015],
                                  colors: [
                                    MyUtils.getCategoryColor(
                                        element.get('category')),
                                    Colors.white
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.GreyBorder,
                                    blurRadius: 10.0,
                                    spreadRadius: 5.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          secondaryActions: <Widget>[
                            SlideAction(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.TrashRedBackground),
                                  child: Image.asset('assets/images/trash.png'),
                                ),
                              ),
                              onTap: () => cTask.deleteTask(docId: element.id),
                            ),
                          ],
                        ),
                      );
                    }
                    dateflag = reminder_at.day;
                  } else {
                    if (reminder_at.isBefore(DateTime.now())) {
                      listwidget.add(
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                          padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset('assets/images/checked.png'),
                              Text(
                                DateFormat('hh.mm a').format(reminder_at),
                                style: TextStyle(color: CustomColors.TextGrey),
                              ),
                              Container(
                                width: 180,
                                child: Text(
                                  element.get('taskname'),
                                  style: TextStyle(
                                      color: CustomColors.TextGrey,
                                      //fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ),
                              (element.get('reminder') == 0)
                                  ? Image.asset('assets/images/bell-small.png')
                                  : Image.asset(
                                      'assets/images/bell-small-yellow.png'),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              stops: [0.015, 0.015],
                              colors: [
                                MyUtils.getCategoryColor(
                                    element.get('category')),
                                Colors.white
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.GreyBorder,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      listwidget.add(
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: InkWell(
                              onTap: () {
                                print('tap');
                                ShowTask(docId: element.id)
                                    .mainBottomSheet(context);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(
                                        'assets/images/checked-empty.png'),
                                    Text(
                                      DateFormat('hh.mm a').format(reminder_at),
                                      style: TextStyle(
                                          color: CustomColors.TextGrey),
                                    ),
                                    Container(
                                      width: 180,
                                      child: Text(
                                        element.get('taskname'),
                                        style: TextStyle(
                                            color: CustomColors.TextHeader,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    (element.get('reminder') == 0)
                                        ? Image.asset(
                                            'assets/images/bell-small.png')
                                        : Image.asset(
                                            'assets/images/bell-small-yellow.png'),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    stops: [0.015, 0.015],
                                    colors: [
                                      MyUtils.getCategoryColor(
                                          element.get('category')),
                                      Colors.white
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CustomColors.GreyBorder,
                                      blurRadius: 10.0,
                                      spreadRadius: 5.0,
                                      offset: Offset(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )),
                          secondaryActions: <Widget>[
                            SlideAction(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: CustomColors.TrashRedBackground),
                                  child: Image.asset('assets/images/trash.png'),
                                ),
                              ),
                              onTap: () => cTask.deleteTask(docId: element.id),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                });
                return ListView(
                    scrollDirection: Axis.vertical, children: listwidget);
              }
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }
}
