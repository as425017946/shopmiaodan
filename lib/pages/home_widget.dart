import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors/my_colors.dart';
import '../utils/style_utils.dart';
import '../utils/widget_utils.dart';

class HomeWidget{
  //公共区域使用
  static Widget itemBuilder(BuildContext context, int i) {
    return Column(
      children: [
        Container(
          height: ScreenUtil().setHeight(28),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: WidgetUtils.onlyTextCenter('1', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('2', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('3', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('4', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                flex: 2,
                child: WidgetUtils.onlyTextCenter('5', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('6', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
            ],
          ),
        ),
        //横线
        WidgetUtils.bgLine(ScreenUtil().setHeight(1), double.infinity),
      ],
    );
  }

  static Widget itemBuilder2(BuildContext context, int i) {
    return Column(
      children: [
        Container(
          height: ScreenUtil().setHeight(28),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: WidgetUtils.onlyTextCenter('1', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('2', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('3', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('5', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('6', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
            ],
          ),
        ),
        //横线
        WidgetUtils.bgLine(ScreenUtil().setHeight(1), double.infinity),
      ],
    );
  }

  static Widget itemBuilder3(BuildContext context, int i) {
    return Column(
      children: [
        Container(
          height: ScreenUtil().setHeight(28),
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: WidgetUtils.onlyTextCenter('1', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('2', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('3', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('5', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
              Expanded(
                child: WidgetUtils.onlyTextCenter('6', StyleUtils.getCommonTextStyle(color: MyColors.m_e01,fontSize: ScreenUtil().setSp(9))),
              ),
            ],
          ),
        ),
        //横线
        WidgetUtils.bgLine(ScreenUtil().setHeight(1), double.infinity),
      ],
    );
  }
}