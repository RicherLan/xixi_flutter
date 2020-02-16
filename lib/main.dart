import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xixi/jishu/add/add_jishuQQWidget.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';
import 'package:xixi/ui/home/HomeWidget.dart';
import 'package:xixi/ui/setting/SettingWidget.dart';
import 'package:xixi/ui/updatePasswordWidget.dart';

import 'config/storage_manager.dart';
import 'jishu/add/add_jishuInfoWidget.dart';
import 'jishu/jishudetail/JishuDeatilWidget.dart';
import 'jishu/search/JishuList/JishuListWidget.dart';
import 'jishu/search/SearchJSOrSkillWidget.dart';
import 'login/loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageManager.init();

  /// App入口
  runApp(new MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前       MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:    Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /// 自定义报错页面
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint(flutterErrorDetails.toString());
    return new Center(child: new Text("App错误，快去反馈给作者!"));
  };
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
//      home: SplashPage(),
      routes: {
        APPRoutePath.LoginWidget: (context) => LoginPage(),
        //登录
        APPRoutePath.UpdatePasswordWidget: (context) => updatePasswordWidget(),
        //修改密码

        APPRoutePath.HomeWidget: (context) => HomeWidget(),
        //首页

        APPRoutePath.SearchJSOrSkillWidget: (context) =>
            SearchJSOrSkillWidget(),
        //搜索界面  搜索技术和语言技术
        APPRoutePath.JishuListWidget: (context) => JishuListWidget(),
        //技术列表
        APPRoutePath.Add_jishuQQWidget: (context) => add_jishuQQWidget(),
        //添加技术qq
//        APPRoutePath.Add_jishuInfoWidget: (context) => add_jishuInfoWidget(),
        //添加技术信息

        APPRoutePath.JishuDetailWidget: (context) => JishuDetailWidget(),
        //某技术信息展示

        APPRoutePath.SettingWidget: (context) => SettingWidget(),
        //设置
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  DateTime __lastPressedBackAt; //上次点击返回键时间

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
          child:   StorageManager.kiplogin.compareTo("no")==0?LoginPage():HomeWidget()
      )
    );
  }
}
