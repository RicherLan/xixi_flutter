import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/bean/Vote.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

class VoteJishuDialogWidget extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onSure;

  Jishu jishu;

  VoteJishuDialogWidget(this.jishu, this.onSure, this.onCancel);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VoteJishuDialogWidgetState();
  }
}

class VoteJishuDialogWidgetState extends State<VoteJishuDialogWidget> {


  String yesOrnoStr;
  String info;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (progressDialogAndTimerToast != null) {
      progressDialogAndTimerToast.cancel(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          SizedBox(
            height: 30,
          ),
          buildyesnoRowRadioButton(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(

                decoration: InputDecoration(
                  labelText: '请输入理由原因',
                ),
                validator: (String value) {
                  //        if(!MyTools.isInteger(value)){
                  //          return "请输入正确的qq格式";
                  //        }
                },
                onChanged: (String value) {
                  info = value;
//                print(widget.jishu.wx);
                }),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("提交"),
                  onPressed: () {
                    doVote();

                  },
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  child: Text("取消"),
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ),
        ]);
  }

  Widget buildyesnoRowRadioButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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



  ProgressDialogAndTimerToast progressDialogAndTimerToast;

  void doVote() async {
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
      return ;
    }

    int yesorno = -1;
    if(yesOrnoStr.compareTo("靠谱")==0){
      yesorno = 1;
    }

    Vote vote = Vote(Service.loginUsername, widget.jishu.qq, yesorno,info);

    progressDialogAndTimerToast =
        ProgressDialogAndTimerToast(HttpUtil.awaitServerTime, "投票失败");
    progressDialogAndTimerToast.begin(context);

    String res = await JishuService.getInstance().voteJishu(vote);

    if (res.compareTo("ok") == 0) {
      progressDialogAndTimerToast.cancel(context);
      if(widget.jishu.yesorno==0){
        if(yesorno==1){
          widget.jishu.yes = widget.jishu.yes+1;
        }else{
          widget.jishu.no = widget.jishu.no+1;
        }
      }else if(widget.jishu.yesorno==1){
        if(yesorno==-1){
          widget.jishu.yes = widget.jishu.yes-1;
          widget.jishu.no = widget.jishu.no+1;
        }
      }else if(widget.jishu.yesorno==-1){
        if(yesorno==1){
          widget.jishu.yes = widget.jishu.yes+1;
          widget.jishu.no = widget.jishu.no-1;
        }
      }
      widget.jishu.yesorno = yesorno;

      Fluttertoast.showToast(
          msg: "投票成功!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      return ;
    } else {
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: res,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return ;
    }
  }
}
