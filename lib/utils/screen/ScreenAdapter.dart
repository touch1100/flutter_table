import 'dart:ui';

import 'package:flutter_table/utils/screen/ScreenUtil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  //屏幕宽度
  static getScreenWith() {
    return ScreenUtil().screenWidth;
  }

  //屏幕高度
  static getScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  //状态栏高度
  static getStatusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }

  //底部安全区距离
  static getBottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }

  //px
  static setSp(double value) {
    return ScreenUtil().setSp(value);
  }
}
