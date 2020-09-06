import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/utilities/auth.dart';
import 'package:todolist/utilities/myutils.dart';
import 'package:todolist/views/pengaturan.dart';

import '../utilities/util.dart';

Widget fullAppbar(BuildContext context) {
  MyScreens().initScreen(context);
  return PreferredSize(
    preferredSize: Size.fromHeight(MyScreens.sizeVertical * 30),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: FullAppBar(
        context: context,
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PengaturanScreen()),
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(
                0, MyScreens.sizeVertical * 2, MyScreens.sizeHorizontal * 5, 0),
            child: CircleAvatar(
                backgroundImage:
                    NetworkImage(AuthService.prefs.getString("photoURL"))),
          ),
        )
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(MyScreens.sizeVertical * 1),
          child: TodayReminder()),
    ),
  );
}

Widget emptyAppbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(75.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hello Bro!',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              'Today you have no tasks',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
          child: Image.asset('assets/images/photo.png'),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
    ),
  );
}

class FullAppBar extends StatefulWidget {
  final context;
  FullAppBar({this.context});
  _FullBarState createState() => _FullBarState(context: this.context);
}

class _FullBarState extends StateMVC<FullAppBar> {
  _FullBarState({this.context}) : super(TaskController()) {
    cTask = controller;
  }
  BuildContext context;
  TaskController cTask;
  int listcount = 0;
  @override
  void initState() {
    super.initState();
    getCount();
  }

  void getCount() async {
    var listcounttoday = await cTask.countTaskToday();
    setState(() {
      listcount = listcounttoday;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MyScreens.sizeVertical * 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello ' + AuthService.prefs.getString("displayName"),
            style: TextStyle(
                fontSize: MyScreens.sizeVertical * 2.2,
                fontWeight: FontWeight.w600),
          ),
          Text(
            'Today you have ' + listcount.toString() + ' tasks',
            style: TextStyle(
                fontSize: MyScreens.sizeVertical * 1.5,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class TodayReminder extends StatefulWidget {
  final context;
  TodayReminder({this.context});
  _TodayReminderState createState() =>
      _TodayReminderState(context: this.context);
}

class _TodayReminderState extends StateMVC<TodayReminder> {
  _TodayReminderState({this.context}) : super(TaskController()) {
    cTask = controller;
  }
  BuildContext context;
  TaskController cTask;
  var lColor = CustomColors.HeaderGreyLight;
  var lTaskName = 'Meeting';
  var lReminder = '13.00 PM';
  var lreminder_at;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyScreens().initScreen(context);
    return StreamBuilder(
      stream: cTask.getTodayReminder(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: MyScreens.sizeVertical * 2,
                horizontal: MyScreens.sizeHorizontal * 5),
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            decoration: BoxDecoration(
              color: CustomColors.HeaderGreyLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'You Have No Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/bell-left.png',
                  scale: 1.3,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          );
        if (snapshot.data.docs.length > 0) {
          snapshot.data.docs.forEach((element) {
            lTaskName = element.get('taskname');
            lreminder_at =
                DateTime.parse(element.get('reminder_at').toDate().toString());
            lReminder = DateFormat('hh.mm a').format(lreminder_at);

            var difference = lreminder_at.difference(DateTime.now()).inMinutes;
            print(difference.toString());
            if (difference <= 60) {
              lColor = CustomColors.YellowAccent;
            } else {
              lColor = CustomColors.HeaderGreyLight;
            }
          });
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: MyScreens.sizeVertical * 2,
                horizontal: MyScreens.sizeHorizontal * 5),
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            decoration: BoxDecoration(
              color: lColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Today Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      lTaskName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      lReminder,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.9,
                ),
                Image.asset(
                  'assets/images/bell-left.png',
                  scale: 1.3,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.symmetric(
                vertical: MyScreens.sizeVertical * 2,
                horizontal: MyScreens.sizeHorizontal * 5),
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            decoration: BoxDecoration(
              color: CustomColors.HeaderGreyLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'You Have No Reminder',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/bell-left.png',
                  scale: 1.3,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
