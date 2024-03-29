import 'dart:ui';
import 'package:flutter/material.dart';

import '../colors/my_colors.dart';
import '../config/config_screen_util.dart';
import '../config/my_config.dart';

///样式工具类
class StyleUtils {
  //登录显示文字样式
  static TextStyle loginTextStyle =
      TextStyle(color: MyColors.black_1, fontSize: ConfigScreenUtil.autoSize30);

  //登录提示文字样式
  static TextStyle loginHintTextStyle =
      TextStyle(color: MyColors.g5, fontSize: ConfigScreenUtil.autoSize7);

  //登录提示文字样式
  static TextStyle buttonTextStyle =
      TextStyle(color: Colors.white, fontSize: ConfigScreenUtil.autoSize36);


  //g3文字样式
  static TextStyle textStyleG3 = TextStyle(
      color: MyColors.g3,
      fontSize: ConfigScreenUtil.autoSize30,
      overflow: TextOverflow.ellipsis);

  //g6文字样式
  static TextStyle textStyleG6 = TextStyle(
      color: MyColors.g6,
      fontSize: ConfigScreenUtil.autoSize30,
      overflow: TextOverflow.ellipsis);

  //g9文字样式
  static TextStyle textStyleG9 = TextStyle(
      color: MyColors.g9,
      fontSize: ConfigScreenUtil.autoSize30,
      overflow: TextOverflow.ellipsis);

  //b1文字样式
  static TextStyle textStyleb1 = TextStyle(
      color: MyColors.black_1,
      fontSize: ConfigScreenUtil.autoSize30,
      overflow: TextOverflow.ellipsis);

  //b3文字样式
  static TextStyle textStyleb3 = TextStyle(
      color: MyColors.black_3,
      fontSize: ConfigScreenUtil.autoSize30,
      overflow: TextOverflow.ellipsis);

  //白色字体30
  static TextStyle whiteTextStyle =
  TextStyle(color: Colors.white, fontSize: ConfigScreenUtil.autoSize24);

  //黑色字体7
  static TextStyle blackTextStyle =
  TextStyle(color: MyColors.m_d2, fontSize: ConfigScreenUtil.autoSize7);

  static TextStyle blackTextStyle2 =
  TextStyle(color: MyColors.m_d2, fontSize: ConfigScreenUtil.autoSize5);

  static TextStyle blackTextStyle3 =
  TextStyle(color: MyColors.m_d2, fontSize: ConfigScreenUtil.autoSize6);

  //白色线条框
  static BoxDecoration wihtieBgStyle = const BoxDecoration(
    color: Colors.white,
  );

  //自定义线框颜色
  static BoxDecoration getCommonBoxDecoration(
      {Color color = Colors.white,
      double? radius = 10,
      double? widthBorder = 1,
      Color colorBorder = Colors.white}) {
    return BoxDecoration(
      //背景
      color: color,
      //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      //设置四周边框
      border: Border.all(width: widthBorder ?? 0, color: colorBorder),
    );
  }

  //自己定义自己修改颜色样式字体大小
  static TextStyle getCommonTextStyle(
      {Color color = MyColors.g3,
      double? fontSize,
      FontWeight? fontWeight,
      TextDecoration? decoration,
      String? fontFamily = MyConfig.mBahnschrift,
      TextOverflow? textOverflow = TextOverflow.ellipsis}) {
    return TextStyle(
        color: color,
        decorationColor: color,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? ConfigScreenUtil.autoSize36,
        decoration: decoration ?? TextDecoration.none,
        fontFamily: fontFamily,
        overflow: textOverflow);
  }
}
