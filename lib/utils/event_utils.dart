import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();


///单选页面点击确认
class HDanXuanBack {

  int index;

  HDanXuanBack({required this.index});
}
///多选页面点击确认
class DuoXuanBack {

  int index;

  DuoXuanBack({required this.index});
}