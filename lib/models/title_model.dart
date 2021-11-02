import 'package:flutter/cupertino.dart';

class TitleModel{
  String title;
  Icon icon;
  bool hasIcon;
  int status; // 0->升序 1->降序

  TitleModel(this.title, {this.icon, this.hasIcon, this.status = 0});
}