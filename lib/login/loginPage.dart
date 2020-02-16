import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/service/userhttpservice/UserService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';
//import 'package:groovin_material_icons/groovin_material_icons.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  bool isLoginSuccess = false;                    //是否成功登录

  final _formKey = GlobalKey<FormState>();
  String _username, _password;
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
//      "icon": GroovinMaterialIcons.facebook,
    },
    {
      "title": "google",
//      "icon": GroovinMaterialIcons.google,
    },
    {
      "title": "twitter",
//      "icon": GroovinMaterialIcons.twitter,
    },
  ];

  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePass = FocusNode();

  // 声明视频控制器
  VideoPlayerController _controller;
  //视频地址
  final String videoUrl =
      "res/raw/loginVideo.mp4";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        // _controller.setVolume(0.0);
        Timer.periodic(Duration(seconds: 15), (Timer time) {
          print(time);
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(progressDialogAndTimerToast!=null){
      progressDialogAndTimerToast.cancel(context);
    }

    _controller.pause();
  }

  DateTime __lastPressedBackAt;
  @override
  Widget build(BuildContext context) {
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
          resizeToAvoidBottomInset:false,          //键盘打开  如果溢出  那么不提示
          resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
          body:Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.scale(
                scale: _controller.value.aspectRatio /
                    MediaQuery.of(context).size.aspectRatio *
                    1.18,
                child: Center(
                  child: Container(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )

//                    child: _controller.value.initialized
//                        ? AspectRatio(
//                      aspectRatio: _controller.value.aspectRatio,
//                      child: VideoPlayer(_controller),
//                    )
//                        : Text("正在初始化"),
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                   physics: ClampingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: kToolbarHeight,
                        ),
                        buildCircleHeader(),
//                        SizedBox(height: 10.0),
                        buildTitle(),
                        buildTitle2(),

//                buildTitleLine(),
                        SizedBox(height: 70.0),
                        buildEmailTextField(),
                        SizedBox(height: 15.0),
                        buildPasswordTextField(context),
                        buildForgetPasswordText(context),
                        SizedBox(height: 25.0),
                        buildLoginButton(context),
                        SizedBox(height: 30.0),
                        buildOtherLoginText(),
                        buildOtherMethod(context),
                        buildRegisterText(context),
                        SizedBox(height: 60.0),
                        Center(
                          child: Text(
                            "我已阅读并同意《服务协议》及《隐私政策》",
                            style: TextStyle(color: Colors.white, fontSize: 13.0),
                          ),
                        )

                      ],
                    ),


                  ))
            ],
          )

      ),
    );

  }

  Widget  buildCircleHeader(){
    return ClipOval(
        child: Image.asset(
          "images/jishuPhoto.jpg",
          width: 55,
          height: 55,
          fit: BoxFit.cover,
        ) ,
    );
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？',style: TextStyle(color: Colors.white),),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                //print('去注册');
               // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
        builder: (context) {
          return IconButton(
              icon: Icon(item['icon'],
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                //TODO : 第三方登录方法
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("${item['title']}登录"),
                  action: new SnackBarAction(
                    label: "取消",
                    onPressed: () {},
                  ),
                ));
              });
        },
      ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ));
  }

  Widget buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25,right: 25),
      child:Align(

        child: SizedBox(
          height: 45.0,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text(
              '登录',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            color: Color(0xe085c2f7),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                ///只有输入的内容符合要求通过才会到达此处
                _formKey.currentState.save();
                //TODO 执行登录方法

                doLogin();

              }

              // doLogin();

            },
            shape: StadiumBorder(),
          ),
        ),
      ),
    );

  }

  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          onPressed: () {
//            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Padding buildPasswordTextField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25,right: 25),
        child: TextFormField(
          focusNode: focusNodePass,
          onSaved: (String value) => _password = value,
          obscureText: _isObscure,
          validator: (String value) {
            if (value.isEmpty) {
              return '请输入密码';
            }
          },
          cursorColor: Colors.green,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(

              labelText: '请输入密码',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.white) ),

              suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: _eyeColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                      _eyeColor = _isObscure
                          ? Colors.white
                          : Theme.of(context).iconTheme.color;
                    });
                  })),
        ),
    );

  }

  Padding buildEmailTextField(){

    return Padding(
        padding: EdgeInsets.only(left: 25,right: 25),
        child:  TextFormField(

          focusNode: focusNodeName,

          style: TextStyle(color: Colors.white),
          cursorColor: Colors.green,
          decoration: InputDecoration(
            labelText: '小姐姐账号是啥',
            labelStyle: TextStyle(color: Colors.white),

            enabledBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.white) ),
          ),
          validator: (String value) {
//        var emailReg = RegExp(
//            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
//        if (!emailReg.hasMatch(value)) {
//          return '请输入正确的邮箱地址';
//        }
          },

          onSaved: (String value) {

            _username = value;
          },
          onChanged: (String value){

            _username = value;
          },

        ),
    );


  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Align buildTitle2() {
    return Align(
        alignment: Alignment.center,
        child:Text('SHOW YOUR IDEAS',
          style: TextStyle(fontSize: 16.0,color: Colors.white),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 8),

      child: Align(
        alignment: Alignment.center,
        child:Text(
//          'BLACK HOUSE',
        "小黑屋",
          style: TextStyle(fontSize: 24.0,color: Colors.white),

        ),
      ),
    );
  }



  ProgressDialogAndTimerToast progressDialogAndTimerToast = null;

  void doLogin() async{

    focusNodeName.unfocus();
    focusNodePass.unfocus();


    progressDialogAndTimerToast = ProgressDialogAndTimerToast(HttpUtil.awaitServerTime,"登录失败");
    progressDialogAndTimerToast.begin(context);

    bool isInternetAccess = await NetworkListener.getINstance().isInternetAccess();

    if(isInternetAccess==false){
      progressDialogAndTimerToast.cancel(context);
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


    String res = await UserService.getInstance().login(_username, _password);


    if(res.compareTo("ok")==0){
      progressDialogAndTimerToast.cancel(context);
      Navigator.pushNamedAndRemoveUntil(context, APPRoutePath.HomeWidget,(route) => route == null,);
    }else if(res.contains("password")){
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "账号或密码错误!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(res.contains("username")){
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "账号或密码错误!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "登录失败!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }


}