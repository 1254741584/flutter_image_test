import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScreenDimens{

  CustomScreenDimens._();

  //基础系数
  static double baseWidth = ScreenUtil.getInstance().setWidth(1);//
  static double baseHeight = ScreenUtil.getInstance().setHeight(1);//
  static double baseSp = ScreenUtil.getInstance().setSp(1);//

  //字体大小
  static double fontSizeS1 = ScreenUtil.getInstance().setSp(22);//小号
  static double fontSizeS2 = ScreenUtil.getInstance().setSp(28);//普通
  static double fontSizeS3 = ScreenUtil.getInstance().setSp(36);//中号
  static double fontSizeS4 = ScreenUtil.getInstance().setSp(48);//大号
  static double fontSizeS5 = ScreenUtil.getInstance().setSp(26);//大号
  static double fontSizeSmall = ScreenUtil.getInstance().setSp(16);//小号
  static double tabFontSizeS1 = ScreenUtil.getInstance().setSp(24);//小号
  static double toastSizeS1 = ScreenUtil.getInstance().setSp(32);//小号
  static double cardSize1 = ScreenUtil.getInstance().setSp(20);//小号

  static double marginSizeS1 = ScreenUtil.getInstance().setWidth(10);//小
  static double marginSizeS2 = ScreenUtil.getInstance().setWidth(20);//普通
  static double marginSizeS3 = ScreenUtil.getInstance().setWidth(30);//中
  static double marginSizeS4 = ScreenUtil.getInstance().setWidth(40);//大

  static double iconSizeS1 = ScreenUtil.getInstance().setWidth(28);//小
  static double iconSizeS2 = ScreenUtil.getInstance().setWidth(40);//普通
  static double iconSizeS3 = ScreenUtil.getInstance().setWidth(64);//中
  static double iconSizeS4 = ScreenUtil.getInstance().setWidth(60);
  static double iconSizeS5 = ScreenUtil.getInstance().setWidth(80);

  static double appBarHeight = baseHeight * 214.0;//appBar高度
  static double tabBarHeight = baseHeight * 86.0;//tabBar高度
  static double singleAppBarHeight = baseHeight * 100.0;//appBar高度
  static double dividerHeight = baseHeight * 2;//appBarHeight


}