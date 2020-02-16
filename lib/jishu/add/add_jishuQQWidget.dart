
/*
  添加技术信息

  添加qq   主要是检测该qq是不是已经添加了
 */


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/jishu/add/add_jishuInfoWidget.dart';
import 'package:xixi/jishu/jishudetail/JishuDeatilWidget.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/method/MyTools.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

void main()=>runApp(add_jishuQQWidget());

class add_jishuQQWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_jishuQQWidgetState();
  }

}

class add_jishuQQWidgetState extends State<add_jishuQQWidget>{

  final _formKey = GlobalKey<FormState>();
  String _qq;

  FocusNode focusNodeQQ = FocusNode();


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
              "添加技术QQ",
              null,
              leftIcon: Icons.arrow_back_ios,
              rightText: "下一步",
              rightClick: () {
                print("点击了干嘛啊。。。哦");
              },
            ),
            preferredSize: Size.fromHeight(50.0)
        ),

        body:Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              buildEmailTextField(),
              SizedBox(height: 60.0),
              buildLoginButton(context),

            ],
          ),
        )
    );

  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      focusNode: focusNodeQQ,
      decoration: InputDecoration(
        labelText: '请输入技术qq',
      ),
      validator: (String value) {
        if(!MyTools.isInteger(value)){
          return "请输入正确的qq格式";
        }
      },
      onSaved: (String value) => _qq = value,
    );
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '下一步',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Color(0xe085c2f7),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
            }

            doSearch();


          },
          shape: StadiumBorder(),
        ),
      ),
    );
  }

  ProgressDialogAndTimerToast progressDialogAndTimerToast = null;

  void doSearch() async{

    focusNodeQQ.unfocus();


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

    progressDialogAndTimerToast = ProgressDialogAndTimerToast(HttpUtil.awaitServerTime,"error,请稍后再试!");
    progressDialogAndTimerToast.begin(context);

    Jishu jishu = await JishuService.getInstance().getJishuByQQ(_qq);
    if(jishu==null){
      progressDialogAndTimerToast.cancel(context);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>add_jishuInfoWidget(_qq)));

    }else if(jishu.qq.compareTo("")==0){
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "服务器飞走了,请稍后再试!",
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
          msg: "该技术已经存在!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );

      Navigator.push(context,MaterialPageRoute(builder: (context)=>JishuDetailWidget(jishu: jishu)));

    }


  }


}