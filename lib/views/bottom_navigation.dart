import 'package:flutter/material.dart';
import 'package:todolist/views/home.dart';
import 'package:todolist/views/task.dart';

import '../utilities/util.dart';

class BottomNavigationBarApp extends StatelessWidget {
  final int bottomNavigationBarIndex;
  final BuildContext context;

  const BottomNavigationBarApp(this.context, this.bottomNavigationBarIndex);

  void onTabTapped(int index) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<Null>(builder: (BuildContext context) {
        return (index == 1) ? TaskView() : Home();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: bottomNavigationBarIndex,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
      selectedItemColor: CustomColors.BlueDark,
      unselectedFontSize: 10,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/home.png',
              color: (bottomNavigationBarIndex == 0)
                  ? CustomColors.BlueDark
                  : CustomColors.TextGrey,
            ),
          ),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/task.png',
              color: (bottomNavigationBarIndex == 1)
                  ? CustomColors.BlueDark
                  : CustomColors.TextGrey,
            ),
          ),
          title: Text('Task'),
        ),
      ],
      onTap: onTabTapped,
    );
  }
}
