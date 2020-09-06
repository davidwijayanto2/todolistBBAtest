import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/utilities/util.dart';

class MyScreens {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double sizeHorizontal;
  static double sizeVertical;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeHorizontal;
  static double safeVertical;
  void initScreen(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    sizeHorizontal = screenWidth / 100;
    sizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class MyUtils {
  static Color getCategoryColor(_category) {
    switch (_category) {
      case 'Personal':
        {
          return CustomColors.YellowIcon;
        }
      case 'Work':
        {
          return CustomColors.GreenIcon;
        }
      case 'Meeting':
        {
          return CustomColors.PurpleIcon;
        }
      case 'Study':
        {
          return CustomColors.BlueIcon;
        }
      case 'Shopping':
        {
          return CustomColors.OrangeIcon;
        }
      case 'Party':
        {
          return CustomColors.DeeppurlpleIcon;
        }
    }
    return Colors.white;
  }
}
