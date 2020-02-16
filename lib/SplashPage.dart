
/*
  开屏页面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:xixi/login/loginPage.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';
import 'package:xixi/ui/home/HomeWidget.dart';



class SplashPage extends StatefulWidget{

  SplashPage({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashPageState();
  }

}

class SplashPageState extends State<SplashPage>{

  String kiplogin = "no";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: goPage,
      child: Image.asset("images/splashImage.jpg",fit: BoxFit.cover,),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDown();
  }


  void countDown()async{
    var duration = Duration(seconds: 3);
    new Future.delayed(duration,goPage);
    kiplogin = await MySharePerferenceAPI.getSharePerferenceString("kiplogin");
    if(kiplogin==null){
      kiplogin = "no";
    }
  }

  bool isStartLoginPage = false;
  void goPage(){
    //如果页面还未跳转过则跳转页面
    if(!isStartLoginPage){
      //跳转主页 且销毁当前页面
      if(kiplogin.compareTo("no")==0){
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>LoginPage()), (Route<dynamic> rout)=>false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>HomeWidget()), (Route<dynamic> rout)=>false);
      }

      isStartLoginPage=true;
    }

  }

}