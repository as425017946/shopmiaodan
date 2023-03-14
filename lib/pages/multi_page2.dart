import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:merchant_second_order/colors/my_colors.dart';
import 'package:merchant_second_order/main.dart';
import 'package:merchant_second_order/utils/style_utils.dart';
import 'package:merchant_second_order/utils/widget_utils.dart';

import '../utils/event_utils.dart';

/// 多选框页面
class MultiPage2 extends StatefulWidget {
  const MultiPage2({Key? key}) : super(key: key);

  @override
  State<MultiPage2> createState() => _MultiPageState();
}

class _MultiPageState extends State<MultiPage2> {
  bool checkboxValue = false,checkboxValue2 = false,checkboxValue3 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(sp.getBool('yhk2') == true){
        checkboxValue = true;
      }else {
        checkboxValue = false;
      }
      if(sp.getBool('wx2') == true){
        checkboxValue2 = true;
      }else {
        checkboxValue2 = false;
      }
      if(sp.getBool('zfb2') == true){
        checkboxValue3 = true;
      }else {
        checkboxValue3 = false;
      }
    });
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
                    checkboxValue = !checkboxValue;
                  });
                }),
                child: Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Checkbox(
                      value: checkboxValue,
                      onChanged: (value) {
                        setState(() {
                          checkboxValue = value!;
                        });
                      },
                    ),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('银行卡', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    checkboxValue2 = !checkboxValue2;
                  });
                }),
                child: Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Checkbox(
                      value: checkboxValue2,
                      onChanged: (value) {
                        setState(() {
                          checkboxValue2 = value!;
                        });
                      },
                    ),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('微信', StyleUtils.blackTextStyle2),
                  ],
                ),
              ),
              WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
              GestureDetector(
                onTap: ((){
                  setState(() {
                    checkboxValue3 = !checkboxValue3;
                  });
                }),
                child:  Row(
                  children: [
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(10)),
                    Checkbox(
                      value: checkboxValue3,
                      onChanged: (value) {
                        setState(() {
                          checkboxValue3 = value!;
                        });
                      },
                    ),
                    WidgetUtils.commonSizedBox(0, ScreenUtil().setWidth(2)),
                    WidgetUtils.onlyText('支付宝', StyleUtils.blackTextStyle2),
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
                      sp.setBool('yhk2', checkboxValue);
                      sp.setBool('wx2', checkboxValue2);
                      sp.setBool('zfb2', checkboxValue3);
                      eventBus.fire(DuoXuanBack(index: 2));
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
