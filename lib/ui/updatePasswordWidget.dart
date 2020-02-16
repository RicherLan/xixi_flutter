
/*
  修改密码
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/service/userhttpservice/UserService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: updatePasswordWidget(),
    );
  }

}

class updatePasswordWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return updatePasswordWidgetState();
  }

}

class updatePasswordWidgetState extends State<updatePasswordWidget>{
  final _formKey = GlobalKey<FormState>();

  String _oldPassStr;
  String _newPassStr1;
  String _newPassStr2;

  bool _isOldObscure = true;
  Color _oldEyeColor;
  bool _isNewObscure1 = true;
  Color _newEyeColor1;
  bool _isNewObscure2 = true;
  Color _newEyeColor2;

  FocusNode focusNodeOld = FocusNode();
  FocusNode focusNodeNew1 = FocusNode();
  FocusNode focusNodeNew2 = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(progressDialogAndTimerToast!=null){
      progressDialogAndTimerToast.cancel(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new BaseViewBar(
          childView: new BaseTitleBar(
            "修改密码",
            null,
            leftIcon: Icons.arrow_back_ios,
            rightText: "提交",
            rightClick: () {
              doSubmit();
            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),
        body: Form(
        key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),

              SizedBox(height: 50.0),
              buildOldPasswordTextField(context),
              SizedBox(height: 50.0),
              buildNewPasswordTextField1(context),
              SizedBox(height: 30.0),
              buildNewPasswordTextField2(context),
              SizedBox(height: 60.0),
              buildSubmitButton(context),
            ],
          ),
        ),

    );
  }

  TextFormField buildOldPasswordTextField(BuildContext context) {
    return TextFormField(
      focusNode: focusNodeOld,
      onSaved: (String value) => _oldPassStr = value,
      obscureText: _isOldObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入旧密码';
        }
      },
      decoration: InputDecoration(
          labelText: '请输入旧密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _oldEyeColor,
              ),
              onPressed: () {
                setState(() {
                  _isOldObscure = !_isOldObscure;
                  _oldEyeColor = _isOldObscure
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildNewPasswordTextField1(BuildContext context) {
    return TextFormField(
      focusNode: focusNodeNew1,
      onSaved: (String value) => _newPassStr1 = value,
      obscureText: _isNewObscure1,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入新密码';
        }
      },
      decoration: InputDecoration(
          labelText: '请输入新密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _newEyeColor1,
              ),
              onPressed: () {
                setState(() {
                  _isNewObscure1 = !_isNewObscure1;
                  _newEyeColor1 = _isNewObscure1
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  TextFormField buildNewPasswordTextField2(BuildContext context) {
    return TextFormField(
      focusNode: focusNodeNew2,
      onSaved: (String value) => _newPassStr2 = value,
      obscureText: _isNewObscure2,
      validator: (String value) {
        if (value.isEmpty) {
          return '请再次输入新密码';
        }
      },
      decoration: InputDecoration(
          labelText: '请再次输入新密码',
          suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _newEyeColor2,
              ),
              onPressed: () {
                setState(() {
                  _isNewObscure2 = !_isNewObscure2;
                  _newEyeColor2 = _isNewObscure2
                      ? Colors.grey
                      : Theme.of(context).iconTheme.color;
                });
              })),
    );
  }

  Container buildSubmitButton(BuildContext context) {

    return Container(
      height: 45.0,
      width: 250.0,
      child:GestureDetector(
        behavior: HitTestBehavior.opaque,  //使用GestureDetector包裹Container，发现在Container内容为空的区域点击时，捕捉不到onTap点击事件。
        child: Center(
          child:Text(
            '提交',
            style: Theme.of(context).primaryTextTheme.headline,

          ),
        ),
        onTap: (){
          doSubmit();
        },
      ),

      /// 实现渐变色的效果
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular((20.0)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(26, 155, 214, 1),
            Color.fromRGBO(54, 209, 193, 1)
          ],
        ),
      ),
    );

  }




  ProgressDialogAndTimerToast progressDialogAndTimerToast = null;
  //提交
  void doSubmit()async{

    if (_formKey.currentState.validate()) {
      ///只有输入的内容符合要求通过才会到达此处
      _formKey.currentState.save();
      //TODO 执行登录方法
    }
    focusNodeOld.unfocus();
    focusNodeNew1.unfocus();
    focusNodeNew2.unfocus();

    if(_newPassStr1.compareTo(_newPassStr2)!=0){
      Fluttertoast.showToast(
          msg: "两次新密码输入不一致!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return ;
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

    progressDialogAndTimerToast = ProgressDialogAndTimerToast(HttpUtil.awaitServerTime,"修改失败");
    progressDialogAndTimerToast.begin(context);

    String res = await UserService.getInstance().updatePassword(Service.loginUsername, _oldPassStr,_newPassStr1);


    if(res.compareTo("ok")==0){
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "密码修改成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);

    }else if(res.contains("oldpassword")){
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "旧密码输入错误!",
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
          msg: "修改失败!",
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