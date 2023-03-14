import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:merchant_second_order/colors/my_colors.dart';
import 'package:merchant_second_order/pages/radio_page.dart';
import 'package:merchant_second_order/utils/log_util.dart';
import 'package:merchant_second_order/utils/my_toast_utils.dart';
import 'package:merchant_second_order/utils/style_utils.dart';
import 'package:merchant_second_order/utils/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utils/event_utils.dart';
import 'home_widget.dart';
import 'multi_page.dart';
import 'multi_page2.dart';

///商家秒单程序页面
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //0秒单 1教你买 2带你卖
  var topStatus = 0;
  List<String> listOne = [];

  // 秒单汇率 秒单数量
  TextEditingController controllerHuiLv = TextEditingController();
  TextEditingController controllerShuLiang = TextEditingController();
  TextEditingController controllerMaiHuiLv = TextEditingController();

  //焦点事件
  final FocusNode _focusNodeHuiLv = FocusNode();
  final FocusNode _focusNodeShuLiang = FocusNode();
  final FocusNode _focusNodeMaiHuiLv = FocusNode();

  //秒单 0前日 1昨日 2今日
  var mdStatus = 2;
  var dnm_type = "未选择";

  //教你买 0前日 1昨日 2今日
  var jnmStatus = 2;
  List<bool> listB1 = [];

  //带你买 0前日 1昨日 2今日
  var dnmStatus = 2;
  List<bool> listB2 = [];
  var xiane = "30000";
  var dnm_type2 = "未选择";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sp.setBool('yhk', false);
    sp.setBool('wx', false);
    sp.setBool('zfb', false);

    sp.setBool('yhk2', false);
    sp.setBool('wx2', false);
    sp.setBool('zfb2', false);

    setState(() {
      for (int i = 0; i < 20; i++) {
        listOne.add('1');
      }
      for (int i = 0; i < 8; i++) {
        if (i == 0) {
          listB1.add(true);
        } else {
          listB1.add(false);
        }
      }
      for (int i = 0; i < 4; i++) {
        if (i == 0) {
          listB2.add(true);
        } else {
          listB2.add(false);
        }
      }
    });
    sp.setInt('jine', 1);
    eventBus.on<HDanXuanBack>().listen((event) {
        switch(event.index){
          case 1:
            setState(() {
              sp.setInt('jine', 1);
              xiane = "30000";
            });
            break;
          case 2:
            setState(() {
              sp.setInt('jine', 2);
              xiane = "50000";
            });
            break;
          case 3:
            setState(() {
              sp.setInt('jine', 3);
              xiane = "70000";
            });
            break;
          case 4:
            setState(() {
              sp.setInt('jine', 4);
              xiane = "100000";
            });
            break;
        }
    });
    //多选
    eventBus.on<DuoXuanBack>().listen((event) {
      switch(event.index){
        case 1:
          setState(() {
            if(sp.getBool('yhk') == true && sp.getBool('wx') == true && sp.getBool('zfb') == true){
              dnm_type = "银行卡/微信/支付宝";
            }else if(sp.getBool('yhk') == true && sp.getBool('wx') == true && sp.getBool('zfb') == false){
              dnm_type = "银行卡/微信";
            }else if(sp.getBool('yhk') == true && sp.getBool('wx') == false && sp.getBool('zfb') == true){
              dnm_type = "银行卡/支付宝";
            }else if(sp.getBool('yhk') == false && sp.getBool('wx') == true && sp.getBool('zfb') == true){
              dnm_type = "微信/支付宝";
            }else if(sp.getBool('yhk') == true && sp.getBool('wx') == false && sp.getBool('zfb') == false){
              dnm_type = "银行卡";
            }else if(sp.getBool('yhk') == false && sp.getBool('wx') == true && sp.getBool('zfb') == false){
              dnm_type = "微信";
            }else if(sp.getBool('yhk') == false && sp.getBool('wx') == false && sp.getBool('zfb') == true){
              dnm_type = "支付宝";
            }else if(sp.getBool('yhk') == false && sp.getBool('wx') == false && sp.getBool('zfb') == false){
              dnm_type = "未选择";
            }
          });
          break;
        case 2:
          setState(() {
            if(sp.getBool('yhk2') == true && sp.getBool('wx2') == true && sp.getBool('zfb2') == true){
              dnm_type2 = "银行卡/微信/支付宝";
            }else if(sp.getBool('yhk2') == true && sp.getBool('wx2') == true && sp.getBool('zfb2') == false){
              dnm_type2 = "银行卡/微信";
            }else if(sp.getBool('yhk2') == true && sp.getBool('wx2') == false && sp.getBool('zfb2') == true){
              dnm_type2 = "银行卡/支付宝";
            }else if(sp.getBool('yhk2') == false && sp.getBool('wx2') == true && sp.getBool('zfb2') == true){
              dnm_type2 = "微信/支付宝";
            }else if(sp.getBool('yhk2') == true && sp.getBool('wx2') == false && sp.getBool('zfb2') == false){
              dnm_type2 = "银行卡";
            }else if(sp.getBool('yhk2') == false && sp.getBool('wx2') == true && sp.getBool('zfb2') == false){
              dnm_type2 = "微信";
            }else if(sp.getBool('yhk2') == false && sp.getBool('wx2') == false && sp.getBool('zfb2') == true){
              dnm_type2 = "支付宝";
            }else if(sp.getBool('yhk2') == false && sp.getBool('wx2') == false && sp.getBool('zfb2') == false){
              dnm_type2 = "未选择";
            }
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false : 字体随着系统的“字体大小”辅助选项来进行缩放
    ScreenUtil.init(context,designSize: const Size(450, 450));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            //横线
            WidgetUtils.bgLine(ScreenUtil().setHeight(1), double.infinity),
            //顶部导航栏
            SizedBox(
              height: ScreenUtil().setHeight(40),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          topStatus = 0;
                        });
                      }),
                      child: Container(
                        color: topStatus == 0
                            ? MyColors.m_top_blue
                            : MyColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetUtils.showImages(
                                'assets/images/m_miaodan.png',
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setHeight(10)),
                            WidgetUtils.commonSizedBox(0, 10),
                            WidgetUtils.onlyText(
                                '秒单',
                                StyleUtils.getCommonTextStyle(
                                    color: MyColors.m_gray,
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                  WidgetUtils.bgLine(
                      ScreenUtil().setHeight(30), ScreenUtil().setHeight(1)),
                  Expanded(
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          topStatus = 1;
                        });
                      }),
                      child: Container(
                        color: topStatus == 1
                            ? MyColors.m_top_blue
                            : MyColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetUtils.showImages(
                                'assets/images/m_pay.png',
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setHeight(10)),
                            WidgetUtils.commonSizedBox(0, 10),
                            WidgetUtils.onlyText(
                                '教你买',
                                StyleUtils.getCommonTextStyle(
                                    color: MyColors.m_gray,
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                  WidgetUtils.bgLine(
                      ScreenUtil().setHeight(30), ScreenUtil().setHeight(1)),
                  Expanded(
                    child: GestureDetector(
                      onTap: (() {
                        setState(() {
                          topStatus = 2;
                        });
                      }),
                      child: Container(
                        color: topStatus == 2
                            ? MyColors.m_top_blue
                            : MyColors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetUtils.showImages(
                                'assets/images/m_mai.png',
                                ScreenUtil().setHeight(10),
                                ScreenUtil().setHeight(10)),
                            WidgetUtils.commonSizedBox(0, 10),
                            WidgetUtils.onlyText(
                                '带你卖',
                                StyleUtils.getCommonTextStyle(
                                    color: MyColors.m_gray,
                                    fontSize: ScreenUtil().setSp(9),
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //横线
            WidgetUtils.bgLine(ScreenUtil().setHeight(1), double.infinity),
            WidgetUtils.commonSizedBox(ScreenUtil().setWidth(5), 0),
            topStatus == 0
                ? Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(25)),
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  mdStatus = 0;
                                });
                              }),
                              child: WidgetUtils.issueButton(
                                  ScreenUtil().setHeight(22),
                                  ScreenUtil().setWidth(28),
                                  '前日',
                                  MyColors.m_green,
                                  MyColors.m_blue,
                                  mdStatus == 0 ? true : false),
                            ),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(7)),
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  mdStatus = 1;
                                });
                              }),
                              child: WidgetUtils.issueButton(
                                  ScreenUtil().setHeight(22),
                                  ScreenUtil().setWidth(28),
                                  '昨日',
                                  MyColors.m_green,
                                  MyColors.m_blue,
                                  mdStatus == 1 ? true : false),
                            ),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(7)),
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  mdStatus = 2;
                                });
                              }),
                              child: WidgetUtils.issueButton(
                                  ScreenUtil().setHeight(22),
                                  ScreenUtil().setWidth(28),
                                  '今日',
                                  MyColors.m_green,
                                  MyColors.m_blue,
                                  mdStatus == 2 ? true : false),
                            ),
                          ],
                        ),
                        WidgetUtils.commonSizedBox(
                            ScreenUtil().setWidth(10), 0),
                        //中间显示部分
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(230),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(25),
                              right: ScreenUtil().setWidth(25)),
                          //边框设置
                          decoration: BoxDecoration(
                            //背景
                            color: Colors.white,
                            //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2.0)),
                            //设置四周边框
                            border: Border.all(width: 1, color: Colors.black),
                          ),
                          child: Column(
                            children: [
                              //头部
                              Container(
                                height: ScreenUtil().setHeight(30),
                                width: double.infinity,
                                color: MyColors.m_e4,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: WidgetUtils.onlyTextCenter(
                                          '购买金额',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: WidgetUtils.onlyTextCenter(
                                          '最低商家汇率',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: WidgetUtils.onlyTextCenter(
                                          '时间',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: WidgetUtils.onlyTextCenter(
                                          '卖U数量',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: WidgetUtils.onlyTextCenter(
                                          '支付方式',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(
                                      child: WidgetUtils.onlyTextCenter(
                                          '商家名称',
                                          StyleUtils.getCommonTextStyle(
                                              color: MyColors.m_e3,
                                              fontSize: ScreenUtil().setSp(9),
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              //信息展示
                              SizedBox(
                                height: ScreenUtil().setHeight(198),
                                width: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: HomeWidget.itemBuilder,
                                  itemCount: listOne.length,
                                ),
                              )
                            ],
                          ),
                        ),
                        WidgetUtils.commonSizedBox(
                            ScreenUtil().setWidth(10), 0),
                        //底部信息
                        Row(
                          children: [
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(40)),
                            WidgetUtils.onlyText(
                                '秒单汇率', StyleUtils.blackTextStyle),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(5)),
                            Container(
                              width: ScreenUtil().setWidth(80),
                              height: ScreenUtil().setHeight(26),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(5),
                                  right: ScreenUtil().setWidth(5),
                                  bottom: ScreenUtil().setWidth(1)),
                              //边框设置
                              decoration: BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                //设置四周边框
                                border:
                                    Border.all(width: 1, color: MyColors.c2),
                              ),
                              child: TextField(
                                focusNode: _focusNodeHuiLv,
                                controller: controllerHuiLv,
                                inputFormatters: [
                                  _MyNumberTextInputFormatter(digit: 6),
                                ],
                                keyboardType: TextInputType.number,
                                //设置键盘为数字
                                style: StyleUtils.getCommonTextStyle(
                                    color: MyColors.m_black,
                                    fontSize: ScreenUtil().setSp(7)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // labelText: "请输入用户名",
                                  // icon: Icon(Icons.people), //前面的图标
                                  hintText: '请输入汇率',
                                  hintStyle: StyleUtils.loginHintTextStyle,
                                  // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
                                ),
                              ),
                            ),
                            WidgetUtils.onlyText(
                                '（以下）', StyleUtils.blackTextStyle),
                            const Expanded(child: Text('')),
                            WidgetUtils.onlyText(
                                '秒单金额', StyleUtils.blackTextStyle),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(5)),
                            Container(
                              width: ScreenUtil().setWidth(80),
                              height: ScreenUtil().setHeight(26),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(5),
                                  right: ScreenUtil().setWidth(5),
                                  bottom: ScreenUtil().setWidth(1)),
                              //边框设置
                              decoration: BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                //设置四周边框
                                border:
                                    Border.all(width: 1, color: MyColors.c2),
                              ),
                              child: TextField(
                                focusNode: _focusNodeShuLiang,
                                controller: controllerShuLiang,
                                inputFormatters: [
                                  _MyNumberTextInputFormatter(digit: 6),
                                ],
                                keyboardType: TextInputType.number,
                                //设置键盘为数字
                                style: StyleUtils.getCommonTextStyle(
                                    color: MyColors.m_black,
                                    fontSize: ScreenUtil().setSp(7)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // labelText: "请输入用户名",
                                  // icon: Icon(Icons.people), //前面的图标
                                  hintText: '请输入秒单金额',
                                  hintStyle: StyleUtils.loginHintTextStyle,
                                  // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
                                ),
                              ),
                            ),
                            WidgetUtils.onlyText(
                                '（元）', StyleUtils.blackTextStyle),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(40)),
                          ],
                        ),
                        //支付方式
                        WidgetUtils.commonSizedBox(
                            ScreenUtil().setWidth(15), 0),
                        Row(
                          children: [
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(40)),
                            WidgetUtils.onlyText(
                                '支付方式', StyleUtils.blackTextStyle),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(5)),
                            GestureDetector(
                              onTap: (() {
                                Future.delayed(const Duration(seconds: 0), () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return MultiPage();
                                      }));
                                });
                              }),
                              child: Container(
                                width: ScreenUtil().setWidth(80),
                                height: ScreenUtil().setHeight(26),
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(5),
                                    right: ScreenUtil().setWidth(5)),
                                //边框设置
                                decoration: BoxDecoration(
                                  //背景
                                  color: Colors.white,
                                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2.0)),
                                  //设置四周边框
                                  border:
                                      Border.all(width: 1, color: MyColors.c2),
                                ),
                                child: Row(
                                  children: [
                                    WidgetUtils.onlyText(
                                        dnm_type, StyleUtils.blackTextStyle3),
                                    const Expanded(child: Text('')),
                                    Container(
                                      width: 1,
                                      height: double.infinity,
                                      color: MyColors.c2,
                                    ),
                                    WidgetUtils.commonSizedBox(
                                        0, ScreenUtil().setWidth(5)),
                                    WidgetUtils.showImages(
                                        'assets/images/m_jiantou.png',
                                        ScreenUtil().setHeight(14),
                                        ScreenUtil().setHeight(14))
                                  ],
                                ),
                              ),
                            ),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(5)),
                            WidgetUtils.onlyText(
                                '(支持多选)', StyleUtils.blackTextStyle),
                            const Expanded(child: Text('')),
                            WidgetUtils.issueButton(
                                ScreenUtil().setHeight(27),
                                ScreenUtil().setWidth(43),
                                '开始秒单',
                                MyColors.m_blue,
                                MyColors.m_blue,
                                true),
                            WidgetUtils.commonSizedBox(
                                0, ScreenUtil().setWidth(130)),
                          ],
                        ),
                      ],
                    ),
                  )
                : topStatus == 1
                    ? Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(25)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      jnmStatus = 0;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '前日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      jnmStatus == 0 ? true : false),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      jnmStatus = 1;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '昨日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      jnmStatus == 1 ? true : false),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      jnmStatus = 2;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '今日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      jnmStatus == 2 ? true : false),
                                ),
                              ],
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(5), 0),
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(25)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[0] = !listB1[0];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '0',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[0]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[1] = !listB1[1];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '100',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[1]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[2] = !listB1[2];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '300',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[2]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[3] = !listB1[3];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '500',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[3]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[4] = !listB1[4];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '700',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[4]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[5] = !listB1[5];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '900',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[5]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[6] = !listB1[6];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '1500',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[6]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear1();
                                      listB1[7] = !listB1[7];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '2000',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB1[7]),
                                ),
                              ],
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(5), 0),
                            //中间显示部分
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(25),
                                    right: ScreenUtil().setWidth(25)),
                                //边框设置
                                decoration: BoxDecoration(
                                  //背景
                                  color: Colors.white,
                                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2.0)),
                                  //设置四周边框
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                ),
                                child: Column(
                                  children: [
                                    //头部
                                    Container(
                                      height: ScreenUtil().setHeight(30),
                                      width: double.infinity,
                                      color: MyColors.m_e4,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: WidgetUtils.onlyTextCenter(
                                                '时间',
                                                StyleUtils.getCommonTextStyle(
                                                    color: MyColors.m_e3,
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: WidgetUtils.onlyTextCenter(
                                                '商家最高买U价',
                                                StyleUtils.getCommonTextStyle(
                                                    color: MyColors.m_e3,
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: WidgetUtils.onlyTextCenter(
                                                '买U数量',
                                                StyleUtils.getCommonTextStyle(
                                                    color: MyColors.m_e3,
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: WidgetUtils.onlyTextCenter(
                                                '支付方式',
                                                StyleUtils.getCommonTextStyle(
                                                    color: MyColors.m_e3,
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: WidgetUtils.onlyTextCenter(
                                                '商家名称',
                                                StyleUtils.getCommonTextStyle(
                                                    color: MyColors.m_e3,
                                                    fontSize:
                                                        ScreenUtil().setSp(9),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //信息展示
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: HomeWidget.itemBuilder2,
                                          itemCount: listOne.length,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(10), 0),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(25)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      dnmStatus = 0;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '前日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      dnmStatus == 0 ? true : false),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      dnmStatus = 1;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '昨日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      dnmStatus == 1 ? true : false),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      dnmStatus = 2;
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(28),
                                      '今日',
                                      MyColors.m_green,
                                      MyColors.m_blue,
                                      dnmStatus == 2 ? true : false),
                                ),
                              ],
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(5), 0),
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(25)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear2();
                                      listB2[0] = !listB2[0];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '30000',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB2[0]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear2();
                                      listB2[1] = !listB2[1];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '50000',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB2[1]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear2();
                                      listB2[2] = !listB2[2];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '70000',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB2[2]),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(7)),
                                GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      clear2();
                                      listB2[3] = !listB2[3];
                                    });
                                  }),
                                  child: WidgetUtils.issueButton(
                                      ScreenUtil().setHeight(22),
                                      ScreenUtil().setWidth(44),
                                      '100000',
                                      MyColors.m_blue,
                                      MyColors.m_blue,
                                      listB2[3]),
                                ),
                              ],
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(5), 0),
                            //中间显示部分
                            Container(
                              width: double.infinity,
                              height: ScreenUtil().setHeight(230),
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(25),
                                  right: ScreenUtil().setWidth(25)),
                              //边框设置
                              decoration: BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(2.0)),
                                //设置四周边框
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              ),
                              child: Column(
                                children: [
                                  //头部
                                  Container(
                                    height: ScreenUtil().setHeight(30),
                                    width: double.infinity,
                                    color: MyColors.m_e4,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: WidgetUtils.onlyTextCenter(
                                              '时间',
                                              StyleUtils.getCommonTextStyle(
                                                  color: MyColors.m_e3,
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Expanded(
                                          child: WidgetUtils.onlyTextCenter(
                                              '商家最高卖U价',
                                              StyleUtils.getCommonTextStyle(
                                                  color: MyColors.m_e3,
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Expanded(
                                          child: WidgetUtils.onlyTextCenter(
                                              '买U总数',
                                              StyleUtils.getCommonTextStyle(
                                                  color: MyColors.m_e3,
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Expanded(
                                          child: WidgetUtils.onlyTextCenter(
                                              '支付方式',
                                              StyleUtils.getCommonTextStyle(
                                                  color: MyColors.m_e3,
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Expanded(
                                          child: WidgetUtils.onlyTextCenter(
                                              '商家名称',
                                              StyleUtils.getCommonTextStyle(
                                                  color: MyColors.m_e3,
                                                  fontSize:
                                                      ScreenUtil().setSp(9),
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //信息展示
                                  SizedBox(
                                    height: ScreenUtil().setHeight(198),
                                    width: double.infinity,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: HomeWidget.itemBuilder3,
                                      itemCount: listOne.length,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(10), 0),
                            //底部信息
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(40)),
                                WidgetUtils.onlyText(
                                    '期望卖出汇率', StyleUtils.blackTextStyle),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(5)),
                                Container(
                                  width: ScreenUtil().setWidth(80),
                                  height: ScreenUtil().setHeight(26),
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(5),
                                      right: ScreenUtil().setWidth(5),
                                      bottom: ScreenUtil().setWidth(1)),
                                  //边框设置
                                  decoration: BoxDecoration(
                                    //背景
                                    color: Colors.white,
                                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2.0)),
                                    //设置四周边框
                                    border: Border.all(
                                        width: 1, color: MyColors.c2),
                                  ),
                                  child: TextField(
                                    focusNode: _focusNodeMaiHuiLv,
                                    controller: controllerMaiHuiLv,
                                    inputFormatters: [
                                      _MyNumberTextInputFormatter(digit: 6),
                                    ],
                                    keyboardType: TextInputType.number,
                                    //设置键盘为数字
                                    style: StyleUtils.getCommonTextStyle(
                                        color: MyColors.m_black,
                                        fontSize: ScreenUtil().setSp(7)),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      // labelText: "请输入用户名",
                                      // icon: Icon(Icons.people), //前面的图标
                                      hintText: '请输入汇率',
                                      hintStyle: StyleUtils.loginHintTextStyle,
                                      // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
                                    ),
                                  ),
                                ),
                                WidgetUtils.onlyText(
                                    '', StyleUtils.blackTextStyle),
                                const Expanded(child: Text('')),
                                WidgetUtils.onlyText(
                                    '对标限额', StyleUtils.blackTextStyle),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(5)),
                                GestureDetector(
                                  onTap: (() {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return RadioPage();
                                              }));
                                    });
                                  }),
                                  child: Container(
                                    width: ScreenUtil().setWidth(80),
                                    height: ScreenUtil().setHeight(26),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(5),
                                        right: ScreenUtil().setWidth(5)),
                                    //边框设置
                                    decoration: BoxDecoration(
                                      //背景
                                      color: Colors.white,
                                      //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2.0)),
                                      //设置四周边框
                                      border: Border.all(
                                          width: 1, color: MyColors.c2),
                                    ),
                                    child: Row(
                                      children: [
                                        WidgetUtils.onlyText(
                                            xiane, StyleUtils.blackTextStyle),
                                        const Expanded(child: Text('')),
                                        Container(
                                          width: 1,
                                          height: double.infinity,
                                          color: MyColors.c2,
                                        ),
                                        WidgetUtils.commonSizedBox(
                                            0, ScreenUtil().setWidth(5)),
                                        WidgetUtils.showImages(
                                            'assets/images/m_jiantou.png',
                                            ScreenUtil().setHeight(14),
                                            ScreenUtil().setHeight(14))
                                      ],
                                    ),
                                  ),
                                ),
                                WidgetUtils.onlyText(
                                    '（单选）', StyleUtils.blackTextStyle),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(40)),
                              ],
                            ),
                            //支付方式
                            WidgetUtils.commonSizedBox(
                                ScreenUtil().setWidth(10), 0),
                            Row(
                              children: [
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(40)),
                                WidgetUtils.onlyText(
                                    '支付方式', StyleUtils.blackTextStyle),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(5)),
                                GestureDetector(
                                  onTap: (() {
                                    Future.delayed(const Duration(seconds: 0),
                                        () {
                                      Navigator.of(context).push(
                                          PageRouteBuilder(
                                              opaque: false,
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return MultiPage2();
                                              }));
                                    });
                                  }),
                                  child: Container(
                                    width: ScreenUtil().setWidth(80),
                                    height: ScreenUtil().setHeight(26),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(5),
                                        right: ScreenUtil().setWidth(5)),
                                    //边框设置
                                    decoration: BoxDecoration(
                                      //背景
                                      color: Colors.white,
                                      //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2.0)),
                                      //设置四周边框
                                      border: Border.all(
                                          width: 1, color: MyColors.c2),
                                    ),
                                    child: Row(
                                      children: [
                                        WidgetUtils.onlyText(
                                            dnm_type2, StyleUtils.blackTextStyle3),
                                        const Expanded(child: Text('')),
                                        Container(
                                          width: 1,
                                          height: double.infinity,
                                          color: MyColors.c2,
                                        ),
                                        WidgetUtils.commonSizedBox(
                                            0, ScreenUtil().setWidth(5)),
                                        WidgetUtils.showImages(
                                            'assets/images/m_jiantou.png',
                                            ScreenUtil().setHeight(14),
                                            ScreenUtil().setHeight(14))
                                      ],
                                    ),
                                  ),
                                ),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(5)),
                                WidgetUtils.onlyText(
                                    '(支持多选)', StyleUtils.blackTextStyle),
                                const Expanded(child: Text('')),
                                WidgetUtils.issueButton(
                                    ScreenUtil().setHeight(27),
                                    ScreenUtil().setWidth(43),
                                    '开始检测',
                                    MyColors.m_blue,
                                    MyColors.m_blue,
                                    true),
                                WidgetUtils.commonSizedBox(
                                    0, ScreenUtil().setWidth(130)),
                              ],
                            ),
                          ],
                        ),
                      )
          ],
        ),
      ),
    );
  }

  Future<void> clear1() async {
    for (int i = 0; i < listB1.length; i++) {
      listB1[i] = false;
    }
  }

  Future<void> clear2() async {
    for (int i = 0; i < listB2.length; i++) {
      listB2[i] = false;
    }
  }
}

class _MyNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  ///允许的小数位数，-1代表不限制位数
  int digit;

  _MyNumberTextInputFormatter({this.digit = -1});

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != "" &&
            value != defaultDouble.toString() &&
            strToFloat(value, defaultDouble) == defaultDouble ||
        getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
