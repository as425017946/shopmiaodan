import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/my_colors.dart';
import '../config/config_screen_util.dart';
import '../config/my_config.dart';
import 'event_utils.dart';
import 'loading.dart';
import 'my_utils.dart';
import 'regex_formatter.dart';
import 'style_utils.dart';

///组件工具类
class WidgetUtils {
  ///appbar 头部
  static Widget getAppBar(
      String title, bool isBack, BuildContext context, bool isCreate) {
    return AppBar(
      //标题居中
      centerTitle: true,
      leading: isBack == true
          ? IconButton(
              icon: WidgetUtils.showImages('assets/images/m_back.png',
                  ConfigScreenUtil.autoHeight39, ConfigScreenUtil.autoWidth21),
              onPressed: (() {
                //如果loading正在显示，让其消失
                Loading.dismiss();
                Navigator.of(context).pop();
              }),
            )
          : const Text(''),
      actions: [
        GestureDetector(
          onTap: (() {
            if (MyUtils.checkClick()) {}
          }),
          child: isCreate == true
              ? GestureDetector(
                  onTap: (() {}),
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin:
                        EdgeInsets.only(right: ConfigScreenUtil.autoWidth30),
                    child: Text(
                      '注册',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "Normal",
                          color: MyColors.ziYellow,
                          fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                )
              : Text(''),
        )
      ],
      title: Text(
        title,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: MyColors.ziYellow,
            fontFamily: "Medium",
            fontSize: ScreenUtil().setSp(30)),
      ),
      elevation: 0,
      //去掉Appbar底部阴影
      //背景颜色
      backgroundColor: MyColors.bg,
    );
  }

  static Widget getTitleWidget(String title, bool isBack, BuildContext context,
      bool isRight, String rightName) {
    return Row(
      children: [
        GestureDetector(
          onTap: (() {
            MyUtils.hideKeyboard(context);
            Navigator.pop(context);
          }),
          child: Row(
            children: [
              WidgetUtils.commonSizedBox(ConfigScreenUtil.autoHeight39, ConfigScreenUtil.autoWidth50),
              WidgetUtils.showImages('assets/images/m_back.png',
                  ConfigScreenUtil.autoHeight39, ConfigScreenUtil.autoWidth21)
            ],
          ),
        ),
        Expanded(
            child: WidgetUtils.onlyTextCenter(
                title,
                StyleUtils.getCommonTextStyle(
                    color: MyColors.ziYellow,
                    fontFamily: MyConfig.mMedium,
                    fontSize: ConfigScreenUtil.autoSize30))),
        GestureDetector(
          onTap: (() {
            if (MyUtils.compare(title, '登录') == 0) {
              eventBus.fire(HeadBack(isBack: true, index: 1));
            }
            if (MyUtils.compare(title, '地址簿') == 0) {
              eventBus.fire(HeadBack(isBack: true, index: 2));
            }
          }),
          child: Text(
            rightName,
            style: StyleUtils.getCommonTextStyle(
                color: MyColors.ziYellow,
                fontFamily: MyConfig.mMedium,
                fontSize: ConfigScreenUtil.autoSize30),
          ),
        ),
        WidgetUtils.commonSizedBox(0, ConfigScreenUtil.autoWidth45),
      ],
    );
  }

  ///登录通用输入账号，密码
  static Widget commonLoginWidget(
    String url,
    TextEditingController content,
    bool obscureText,
    String hintText,
  ) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 10, 40, 10),
      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
      height: ConfigScreenUtil.autoHeight80,
      width: double.infinity,
      child: Row(
        children: [
          WidgetUtils.showImages(url, ConfigScreenUtil.autoHeight50,
              ConfigScreenUtil.autoHeight50),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              //边框设置
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1, //宽度
                    color: MyColors.b8, //边框颜色
                  ),
                ),
              ),
              child: TextField(
                obscureText: obscureText,
                controller: content,
                inputFormatters: [
                  RegexFormatter(regex: MyUtils.regexFirstNotNull),
                ],
                style: StyleUtils.loginTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // labelText: "请输入用户名",
                  // icon: Icon(Icons.people), //前面的图标
                  hintText: hintText,
                  hintStyle: StyleUtils.loginHintTextStyle,
                  // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///通用
  static Widget commonTextField(
      TextEditingController controller, String hintText, bool isHide, FocusNode focusNode) {
    return TextField(
      focusNode: focusNode,
      obscureText: isHide,
      controller: controller,
      minLines: 1,
      inputFormatters: [
        RegexFormatter(regex: MyUtils.regexFirstNotNull),
      ],
      style: StyleUtils.getCommonTextStyle(color: MyColors.ziYellow, fontSize: ConfigScreenUtil.autoSize30),
      onChanged: (value) {

      },
      decoration: InputDecoration(
        border: InputBorder.none,
        // labelText: "请输入用户名",
        // icon: Icon(Icons.people), //前面的图标
        hintText: hintText,
        hintStyle: StyleUtils.loginHintTextStyle,
        // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
      ),
    );
  }

  ///通用数字键盘，只能输入数字和小数（小数6位）
  static Widget commonTextFieldNumber(
      {required TextEditingController controller,
      required String hintText,
      bool? enabled = true,
        FocusNode? focusNode}) {
    return TextField(
      focusNode: focusNode,
      enabled: enabled,
      controller: controller,
      inputFormatters: [
        _MyNumberTextInputFormatter(digit:6),
      ],
      keyboardType: TextInputType.number,
      //设置键盘为数字
      style: StyleUtils.getCommonTextStyle(color: MyColors.ziYellow, fontSize: ConfigScreenUtil.autoSize30),
      decoration: InputDecoration(
        border: InputBorder.none,
        // labelText: "请输入用户名",
        // icon: Icon(Icons.people), //前面的图标
        hintText: hintText,
        hintStyle: StyleUtils.loginHintTextStyle,
        // prefixIcon: Icon(Icons.people_alt_rounded)//和文字一起的图标
      ),
    );
  }

  ///通用登录大按钮
  static Widget commonSubmitButton(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 10, 40, 0),
      height: ConfigScreenUtil.autoHeight90,
      alignment: Alignment.center,
      width: double.infinity,
      //边框设置
      decoration: BoxDecoration(
        //背景
        color: MyColors.blue,
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        //设置四周边框
        border: Border.all(width: 1, color: MyColors.blue),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        height: ConfigScreenUtil.autoHeight80,
        splashColor: MyColors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        onPressed: (() {
          if (MyUtils.checkClick()) {}
        }),
        child: Text(
          title,
          style: StyleUtils.buttonTextStyle,
        ),
      ),
    );
  }

  ///通用登录大按钮
  static Widget commonSubmitButton2(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      height: ConfigScreenUtil.autoHeight80,
      alignment: Alignment.center,
      width: double.infinity,
      //边框设置
      decoration: BoxDecoration(
        //背景
        color: MyColors.blue,
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        //设置四周边框
        border: Border.all(width: 1, color: MyColors.blue),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        height: ConfigScreenUtil.autoHeight80,
        splashColor: MyColors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        onPressed: (() {}),
        child: Text(
          title,
          style: StyleUtils.whiteTextStyle,
        ),
      ),
    );
  }

  ///通用SizedBox
  static Widget commonSizedBox(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  ///通用横线
  static Widget myLine(
      {Color? color = MyColors.f5,
      double? thickness = 1,
      double? indent = 0,
      double? endIndent = 0}) {
    return Divider(
      color: color,
      indent: indent,
      endIndent: endIndent,
      // 线的厚度
      thickness: thickness,
    );
  }

  ///通用我的横条白底选择框
  static Widget whiteKuang(String imageUrl, String title, bool isVersion) {
    return GestureDetector(
      onTap: (() {}),
      child: Container(
        height: ConfigScreenUtil.autoHeight90,
        width: double.infinity,
        decoration: StyleUtils.wihtieBgStyle,
        child: Row(
          children: [
            SizedBox(
              width: ConfigScreenUtil.autoHeight20,
            ),
            Image(
              image: AssetImage(imageUrl),
              width: ConfigScreenUtil.autoHeight40,
              height: ConfigScreenUtil.autoHeight40,
            ),
            SizedBox(
              width: ConfigScreenUtil.autoHeight10,
            ),
            Text(
              title,
              style: StyleUtils.textStyleG3,
            ),
            const Expanded(child: Text('')),
            Text(
              '',
              style: StyleUtils.textStyleG3,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            // Text(sp.getString('gengxin').toString(),
            //     style: StyleUtils.textStyleG9),
            SizedBox(
              width: ScreenUtil().setWidth(10),
            ),
            Image(
              image: const AssetImage('assets/images/more.png'),
              width: ScreenUtil().setHeight(40),
              height: ScreenUtil().setHeight(40),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(20),
            ),
          ],
        ),
      ),
    );
  }

  ///背景色
  static Widget bgLine(double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.f5,
      ),
      child: const Text(''),
    );
  }

  ///带边框的发布按钮
  static Widget issueButton(String title, Color boxColors, Color borderColors,
      Color txtColors, bool isClick, int type) {
    return GestureDetector(
      onTap: (() {}),
      child: Container(
        width: ScreenUtil().setWidth(180),
        height: ScreenUtil().setHeight(50),
        alignment: Alignment.center,
        //边框设置
        decoration: BoxDecoration(
          //背景
          color: boxColors,
          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          //设置四周边框
          border: Border.all(width: 1, color: borderColors),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: ScreenUtil().setSp(30), color: txtColors),
        ),
      ),
    );
  }

  ///直接显示信息的text(例：居民姓名：张三)
  static Widget onlyText(
    String title,
    TextStyle style,
  ) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: style,
        maxLines: 10,
      ),
    );
  }

  ///直接显示信息的text(例：居民姓名：张三)
  static Widget onlyTextCenter(
    String title,
    TextStyle style,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: style,
      ),
    );
  }

  ///直接显示信息的text(例：居民姓名：张三)
  static Widget onlyTextTitle({
    required String title,
    required TextStyle style,
    required double maxWidth,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: style,
      ),
    );
  }

  ///直接显示信息的text，左右两侧显示(例：居民姓名：好多空格    张三)
  static Widget onlyTextLeftRight(
      String title, String info, TextStyle leftStyle, TextStyle rightStyle) {
    return Container(
      height: ConfigScreenUtil.autoHeight50,
      width: double.infinity,
      //边框设置
      decoration: StyleUtils.getCommonBoxDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: ConfigScreenUtil.autoHeight20,
          ),
          Text(
            title,
            style: leftStyle,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                info,
                style: rightStyle,
              ),
            ),
          ),
          SizedBox(
            width: ConfigScreenUtil.autoHeight20,
          ),
        ],
      ),
    );
  }

  ///直接显示信息的text，左右两侧显示(例：居民姓名：好多空格    >)
  static Widget onlyTextLeftRightImg(
      String title, TextStyle leftStyle, String url) {
    return Container(
      height: ConfigScreenUtil.autoHeight50,
      width: double.infinity,
      //边框设置
      decoration: StyleUtils.getCommonBoxDecoration(),
      child: Row(
        children: [
          SizedBox(
            width: ConfigScreenUtil.autoHeight20,
          ),
          Text(
            title,
            style: leftStyle,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: WidgetUtils.showImages(url, 15, 20),
            ),
          ),
          SizedBox(
            width: ConfigScreenUtil.autoHeight20,
          ),
        ],
      ),
    );
  }

  ///展示图片使用 正常显示
  static Widget showImages(String url, double height, double width) {
    return Image(
        image: AssetImage(url),
        width: width,
        height: height,
        fit: BoxFit.contain);
  }

  ///展示图片使用
  static Widget showImagesFill(String url, double height, double width) {
    return Image(
        image: AssetImage(url), width: width, height: height, fit: BoxFit.fill);
  }

  ///自定义圆角背景框
  static Widget myContainer(double height, double width, Color boxColors,
      Color borderColors, String title, double size, Color txtColors) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      //边框设置
      decoration: BoxDecoration(
        //背景
        color: boxColors,
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        //设置四周边框
        border: Border.all(width: 1, color: borderColors),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: size, color: txtColors),
      ),
    );
  }

  static Widget commonContainer(bool isClick, String title, int height, int width) {
    return Container(
      height: ScreenUtil().setHeight(height),
      width: ScreenUtil().setWidth(width),
      alignment: Alignment.center,
      //边框设置
      decoration: BoxDecoration(
        //背景
        color: isClick ? MyColors.ziYellow : MyColors.bg,
        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1, color: MyColors.ziYellow),
      ),
      child: Text(
        title,
        style: StyleUtils.getCommonTextStyle(
            color: isClick ? MyColors.loginZiBlack : MyColors.ziYellow,
            fontSize: ConfigScreenUtil.autoSize30),
      ),
    );
  }
}

class _MyNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;
  ///允许的小数位数，-1代表不限制位数
  int digit;
  _MyNumberTextInputFormatter({this.digit=-1});
  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }
  ///获取目前的小数位数
  static int getValueDigit(String value){
    if(value.contains(".")){
      return value.split(".")[1].length;
    }else{
      return -1;
    }
  }


  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (value == ".") {
      value = "0.";
      selectionIndex++;
    } else if (value != ""
        && value != defaultDouble.toString()
        && strToFloat(value, defaultDouble) == defaultDouble
        ||getValueDigit(value)>digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
