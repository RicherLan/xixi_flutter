

import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/service/userhttpservice/UserService.dart';
import 'package:xixi/tools/MyUITools/MyDialogs.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

import 'DongtaiWidget/DongtaiWidget.dart';
import 'FirstWidget/FirstWidget.dart';
import 'MessageWidget/MessageWidget.dart';
import 'MineWidget/MineWidget.dart';

class HomeWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return HomeWidgetState();
  }

}

class HomeWidgetState extends State<HomeWidget>{

  int _selectedIndex  = 0;
  final _widgetItems = [FirstWidget(),MessageWidget(),DongtaiWidget(),MineWidget()];

  DateTime __lastPressedBackAt;

  //网络状态描述
  String _connectStateDescription;

  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState();

      //监测网络变化
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.mobile) {

          print("网络切换  尝试登录");
          // 延时1s执行返回
          Future.delayed(Duration(seconds: 2), (){
            UserService.getInstance().login(Service.loginUsername,Service.loginPassword);
          });


          setState(() {
            _connectStateDescription = "手机网络";
          });
        } else if (result == ConnectivityResult.wifi) {
          print("网络切换  尝试登录");
          // 延时1s执行返回
          Future.delayed(Duration(seconds: 2), (){
            UserService.getInstance().login(Service.loginUsername,Service.loginPassword);
          });

          setState(() {
            _connectStateDescription = "Wifi网络";
          });
        } else {
          setState(() {
            _connectStateDescription = "无网络";
          });
        }

        print(_connectStateDescription);
      });

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(subscription!=null){
      subscription.cancle();
    }
    if(_timer!=null){
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
      onWillPop: () async{
        if(__lastPressedBackAt==null||DateTime.now().difference(__lastPressedBackAt)>Duration(seconds: 1)){
          //两次点击时间超过1秒
          __lastPressedBackAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Center(
          child: _widgetItems[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("首页")),
            BottomNavigationBarItem(icon: Icon(Icons.message),title: Text("消息")),
            BottomNavigationBarItem(icon: Icon(Icons.mood),title: Text("动态")),
            BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("我的")),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
    );
  }


  void _onItemTapped(int index){

    setState(() {
      _selectedIndex = index;
    });
  }


  Timer _timer ;
  int loginTryCount = 0;
  /*
    检测登录状态   如果是跳过登录界面直接来到首界面   那么要再次尝试登录
   */
  void checkLoginState() async{
    String kiplogin = await MySharePerferenceAPI.getSharePerferenceString("kiplogin");

    if(kiplogin==null||kiplogin!=null&&kiplogin.compareTo("no")==0){
      if(_timer!=null){
        _timer.cancel();

//        弹窗登录
        MyDialogs.showNeedLoginDialog(context,"身份信息已过期,请重新登录");
      }
    }else{
      Service.loginUsername = await MySharePerferenceAPI.getSharePerferenceString("username");
      Service.loginPassword = await MySharePerferenceAPI.getSharePerferenceString("password");

    }

    login();
    _timer = Timer.periodic(Duration(seconds: 30), (timer){
      login();
    });

  }


  void login() async{
    if(loginTryCount>=3){
      _timer.cancel();
      return;
    }


    bool isInternetAccess = await NetworkListener.getINstance().isInternetAccess();

    if(isInternetAccess==false){
      Fluttertoast.showToast(
          msg: "当前无可用网络!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return;
    }

    String res = await UserService.getInstance().login(Service.loginUsername,Service.loginPassword);


    if(res.compareTo("ok")==0){
      _timer.cancel();
      MySharePerferenceAPI.setSharePerferenceString("username", Service.loginUsername);
      MySharePerferenceAPI.setSharePerferenceString("password", Service.loginPassword);
      MySharePerferenceAPI.setSharePerferenceString("kiplogin", "yes");

    }else if(res.contains("password")){
      _timer.cancel();
      //弹窗
      MyDialogs.showNeedLoginDialog(context,"账号或密码错误,请重新登录");

    }else if(res.contains("username")){
      _timer.cancel();
      //弹窗
      MyDialogs.showNeedLoginDialog(context,"账号或密码错误,请重新登录");

    }

    ++loginTryCount;
  }


}

