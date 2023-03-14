import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:merchant_second_order/colors/my_colors.dart';
import 'package:merchant_second_order/main.dart';
import 'package:merchant_second_order/utils/style_utils.dart';
import 'package:merchant_second_order/utils/widget_utils.dart';

import '../utils/event_utils.dart';

/// 单选框
class RadioPage extends StatefulWidget {
  const RadioPage({Key? key}) : super(key: key);

  @override
  State<RadioPage> createState() => _MultiPageState();
}

class _MultiPageState extends State<RadioPage> {
  bool checkboxValue = false,checkboxValue2 = false,checkboxValue3 = false;
 var groupValue = 1;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(sp.getInt('jine')){
      case 1:
        setState(() {
          groupValue = 1;
        });
        break;
      case 2:
        setState(() {
          groupValue = 2;
        });
        break;
      case 3:
        setState(() {
          groupValue = 3;
        });
        break;
      case 4:
        setState(() {
          groupValue = 4;
        });
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.translucence,
      body: Center(
        child: Container(
            height: ScreenUtil().setHeight(200),
            width: ScreenUtil().setWidth(100),
            //边框设置
            decoration: const BoxDecoration(
              //背景
              color: MyColors.white,
              //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          child: Column(
            children: [
              WidgetUtils.commonSizedBox(ScreenUtil().setHeight(10), 0),
              WidgetUtils.onlyTextCenter('请选择支付方式', StyleUtils.blackTextStyle),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(10), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    groupValue = 1;
                  });
                }),
                child: Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Radio(value: 1, groupValue: groupValue, onChanged: (val){
                      setState(() {
                        groupValue = 1;
                      });
                    }),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('30000', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    groupValue = 2;
                  });
                }),
                child: Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Radio(value: 2, groupValue: groupValue, onChanged: (value){
                      setState(() {
                        groupValue = 2;
                      });
                    }),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('50000', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    groupValue = 3;
                  });
                }),
                child:  Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Radio(value: 3, groupValue: groupValue, onChanged: (value){
                      setState(() {
                        groupValue = 3;
                      });
                    }),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('70000', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    groupValue = 4;
                  });
                }),
                child:  Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Radio(value: 4, groupValue: groupValue, onChanged: (value){
                      setState(() {
                        groupValue = 4;
                      });
                    }),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('100000', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              const Expanded(child: Text('')),
              Row(
                children: [
                  WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(5)),
                  GestureDetector(
                    onTap: ((){
                      Navigator.pop(context);
                    }),
                    child: Container(
                      height: ScreenUtil().setHeight(20),
                      width: ScreenUtil().setWidth(40),
                      //边框设置
                      decoration: const BoxDecoration(
                        //背景
                        color: MyColors.m_green,
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: WidgetUtils.onlyTextCenter('取消', StyleUtils.getCommonTextStyle(color: MyColors.white,fontSize: ScreenUtil().setSp(5))),
                    ),
                  ),
                  const Expanded(child: Text('')),
                  GestureDetector(
                    onTap: ((){
                      eventBus.fire(HDanXuanBack(index: groupValue));
                      Navigator.pop(context);
                    }),
                    child: Container(
                      height: ScreenUtil().setHeight(20),
                      width: ScreenUtil().setWidth(40),
                      //边框设置
                      decoration: const BoxDecoration(
                        //背景
                        color: MyColors.m_blue,
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: WidgetUtils.onlyTextCenter('确认', StyleUtils.getCommonTextStyle(color: MyColors.white,fontSize: ScreenUtil().setSp(5))),
                    ),
                  ),
                  WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(5)),
                ],
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(10), 0),
            ],
          ),
        ),
      ),
    );
  }
}
