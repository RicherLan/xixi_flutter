
/*
  添加技术其他信息
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';




class add_jishuInfoWidget extends StatefulWidget{


  String _qq ;
  add_jishuInfoWidget(this._qq);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return add_jishuInfoWidgetState(_qq);
  }

}
class add_jishuInfoWidgetState extends State<add_jishuInfoWidget>{

  add_jishuInfoWidgetState(this._qq);

  final _formKey = GlobalKey<FormState>();
  String _qq ;
  String _wx ;
  int _yes = 0;                   //支持数量
  int _no = 0;                   //否定数量

  String yesOrnoStr;

  String _info = "";                //其他信息
  String _label = "";                //标签
  String _skill = "";              //会的技术语言



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
    return (
       Scaffold(
        appBar: new BaseViewBar(
            childView: new BaseTitleBar(
              "添加技术信息",
              null,
              leftIcon: Icons.arrow_back_ios,
              rightText: "提交",
              rightClick: () {
                doSubmit();
              },
            ),
            preferredSize: Size.fromHeight(50.0)
        ),
        body:  Form(
          key: _formKey,
          child: ListView(

            padding: EdgeInsets.symmetric(horizontal: 22.0),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight,
              ),
              buildQQText(),
              SizedBox(height: 30.0),
              buildWXTextField(),
              SizedBox(height: 30.0),
              buildyesnoRowRadioButton(),
              SizedBox(height: 30.0),
              buildSkillTextField(),
              SizedBox(height: 30.0),
              buildLabelTextField(),
              SizedBox(height: 30.0),
              buildInfoTextField(),
              SizedBox(height: 60.0),
              buildSubmitButton(context),
              SizedBox(height: 30.0),
            ],

          ),
        ),

      )
    );

  }

  Center buildQQText(){

    Size size = MediaQuery.of(context).size;
    Gradient gradient = LinearGradient(colors: [Colors.blueAccent,Colors.greenAccent]);
    Shader shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    return Center(
      child: Text(
        "扣扣: "+_qq,
        style: TextStyle(
          fontSize: 28,
          foreground: Paint()..shader = shader,
        ),
      ),
    );
  }

  Widget buildyesnoRowRadioButton(){
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile<String>(
            value: '靠谱',
            title: Text('靠谱'),
            groupValue: yesOrnoStr,
            onChanged: (value) {
              setState(() {
                yesOrnoStr = value;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: '不靠谱',
            title: Text('不靠谱'),
            groupValue: yesOrnoStr,
            onChanged: (value) {
              setState(() {
                yesOrnoStr = value;
              });
            },
          ),
        ),
      ],
    );

  }

  TextFormField buildWXTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '请输入技术微信 (选填)',
      ),
      validator: (String value) {
//        if(!MyTools.isInteger(value)){
//          return "请输入正确的qq格式";
//        }
      },
      onSaved: (String value) => _wx = value,
    );
  }

  TextFormField buildSkillTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '请输入技术熟悉的技术语言栈 (选填)',
      ),
      validator: (String value) {
//        if(!MyTools.isInteger(value)){
//          return "请输入正确的qq格式";
//        }
      },
      onSaved: (String value) => _skill = value,
    );
  }

  TextFormField buildLabelTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '技术标签,空格分开,例:大单子 报价低  (选填)',
      ),
      validator: (String value) {
//        if(!MyTools.isInteger(value)){
//          return "请输入正确的qq格式";
//        }
      },
      onSaved: (String value) => _label = value,
    );
  }

  TextFormField buildInfoTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '投票靠谱或者不靠谱的原因 (写一下)',
      ),
      validator: (String value) {
//        if(!MyTools.isInteger(value)){
//          return "请输入正确的qq格式";
//        }
      },
      onChanged: (String value) => _info = value,
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


  ProgressDialogAndTimerToast progressDialogAndTimerToast;

  Future<bool> doSubmit() async {

    if (_formKey.currentState.validate()) {
      ///只有输入的内容符合要求通过才会到达此处
      _formKey.currentState.save();
      //TODO 执行登录方法
    }

    if(yesOrnoStr==null||yesOrnoStr.isEmpty){
      Fluttertoast.showToast(
          msg: "请投票!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    

    bool isInternetAccess =
    await NetworkListener.getINstance().isInternetAccess();

    if (isInternetAccess == false) {
      Fluttertoast.showToast(
          msg: "当前无可用网络!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }

    int yesorno = 1;
    if(yesOrnoStr.compareTo("靠谱")==0){
      yesorno = 1;
      _yes = 1;
    }else{
      yesorno = -1;
      _no = 1;
    }

    Jishu jishu = Jishu(_qq, _wx,_yes,_no, _info, _label, _skill,yesorno);

    progressDialogAndTimerToast =
        ProgressDialogAndTimerToast(HttpUtil.awaitServerTime, "添加失败");
    progressDialogAndTimerToast.begin(context);

    String res = await JishuService.getInstance().addJishu(jishu);

    if (res.compareTo("ok") == 0) {
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "添加成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      return true;
    } else {
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "添加失败!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

}