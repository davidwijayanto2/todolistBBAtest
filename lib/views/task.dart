import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:todolist/controller/task_controller.dart';
import 'package:todolist/views/app_bars.dart';
import 'package:todolist/views/bottom_navigation.dart';
import 'package:todolist/views/fab.dart';
import 'package:todolist/utilities/util.dart';

class TaskView extends StatefulWidget {
  TaskView({Key key}) : super(key: key);

  _TaskState createState() => _TaskState();
}

class _TaskState extends StateMVC<TaskView> {
  _TaskState() : super(TaskController()) {
    cTask = controller;
  }
  final bottomNavigationBarIndex = 1;
  TaskController cTask;
  Map<String, dynamic> listcount;
  int listcounttoday = 0;
  var lPersonal = '0',
      lWork = '0',
      lMeeting = '0',
      lStudy = '0',
      lShopping = '0',
      lParty = '0';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataCount();
  }

  void getDataCount() async {
    listcount = await cTask.countTaskCategory();
    setState(() {
      lPersonal = listcount['personal'].toString();
      lWork = listcount['work'].toString();
      lMeeting = listcount['meeting'].toString();
      lStudy = listcount['study'].toString();
      lShopping = listcount['shopping'].toString();
      lParty = listcount['party'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: fullAppbar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Container(
                        margin: EdgeInsets.only(left: 10, top: 15, bottom: 0),
                        child: Text(
                          'Projects',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.TextSubHeader),
                        ),
                      ),
                  childCount: 1),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              children: [
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child: Image.asset('assets/images/icon-user.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.YellowBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Personal',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lPersonal + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child:
                                Image.asset('assets/images/icon-briefcase.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.GreenBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Work',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lWork + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                                'assets/images/icon-presentation.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.PurpleBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Meeting',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lMeeting + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child: Image.asset(
                                'assets/images/icon-shopping-basket.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.OrangeBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Shopping',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lShopping + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child:
                                Image.asset('assets/images/icon-confetti.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.BlueBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Party',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lParty + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
                Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 65,
                            height: 65,
                            child:
                                Image.asset('assets/images/icon-molecule.png'),
                            decoration: const BoxDecoration(
                              color: CustomColors.PurpleBackground,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Study',
                            style: TextStyle(
                                fontSize: 17,
                                color: CustomColors.TextHeaderGrey,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            lStudy + ' Tasks',
                            style: TextStyle(
                                fontSize: 9,
                                color: CustomColors.TextSubHeaderGrey),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
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
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10),
                    height: 150.0),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(context),
      bottomNavigationBar:
          BottomNavigationBarApp(context, bottomNavigationBarIndex),
    );
  }
}
