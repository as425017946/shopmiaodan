import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();


///首页点击侧滑
class HeadBack {
  bool isBack;

  int index; //1登录使用的注册 2添加地址使用

  HeadBack({required this.isBack, required this.index});
}

/// 输入框返回值
class InputBack {
  bool isBack;
  String value;//返回值
  String title;//返回标题名字
  InputBack({required this.isBack, required this.value, required this.title});
}

///手机底部导航按钮切换
class BottomBack {
  int index; //0 第一页 1 第二页 2 第三页

  BottomBack({ required this.index});
}


///买卖币页面使用
class BiBack {
  bool isBack;
  int index; //0购买 1出售 2选择完收款地址 3进入订单页面

  BiBack({required this.isBack, required this.index});
}

///买卖币页面使用
class OrderBack {
  int index; //0进入订单页面

  OrderBack({required this.index});
}