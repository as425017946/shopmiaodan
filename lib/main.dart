import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:merchant_second_order/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


//定义一个全局的存储对象
late SharedPreferences sp;
void main() async{
  //加入后可正常使用
  WidgetsFlutterBinding.ensureInitialized();
  //初始化存储
  sp = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '商家秒单系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
