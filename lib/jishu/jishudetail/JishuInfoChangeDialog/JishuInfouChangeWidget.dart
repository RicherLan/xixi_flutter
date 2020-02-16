import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

class JishuInfouChangeWidget extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onSure;

  Jishu jishu;
  int index;

  Jishu jishu2;
  String contentStr = ""; //原来的内容   一旦修改失败   jishu对象要恢复   因为是引用传递
  String text; //修改之后的内容

  JishuInfouChangeWidget(this.jishu, this.index, this.onSure, this.onCancel);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JishuInfouChangeWidgetState();
  }
}

class JishuInfouChangeWidgetState extends State<JishuInfouChangeWidget> {
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

    widget.jishu2 = Jishu.fromJson(widget.jishu.toJson());

    switch (widget.index) {
      case 1:
        widget.contentStr = widget.jishu.wx;
        break;
      case 2:
        widget.contentStr = widget.jishu.skill;
        break;
      case 3:
        widget.contentStr = widget.jishu.label;
        break;
      case 4:
        widget.contentStr = widget.jishu.info;
        break;
    }
    // TODO: implement build
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Text(
              widget.contentStr==null?"":widget.contentStr,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: widget.contentStr==null?"":widget.contentStr,
                    // 保持光标在最后
                    selection: TextSelection.fromPosition(TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: widget.contentStr==null?0:widget.contentStr.length)))),
                decoration: InputDecoration(
                  labelText: '请输入修改后的内容',
                ),
                validator: (String value) {
                  //        if(!MyTools.isInteger(value)){
                  //          return "请输入正确的qq格式";
                  //        }
                },
                onChanged: (String value) {
                  widget.text = value;
//                print(widget.jishu.wx);
                  switch (widget.index) {
                    case 1:
                      widget.jishu2.wx = value;
                      break;
                    case 2:
                      widget.jishu2.skill = value;
                      break;
                    case 3:
                      widget.jishu2.label = value;
                      break;
                    case 4:
                      widget.jishu2.info = value;
                      break;
                  }
                  ;
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
                  child: Text("修改"),
                  onPressed: () {
                     doUpdate();

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



  ProgressDialogAndTimerToast progressDialogAndTimerToast;

  Future<bool> doUpdate() async {
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

    progressDialogAndTimerToast =
        ProgressDialogAndTimerToast(HttpUtil.awaitServerTime, "修改失败");
    progressDialogAndTimerToast.begin(context);

    String res = await JishuService.getInstance().supplyJishu(widget.jishu2);

    if (res.compareTo("ok") == 0) {
      progressDialogAndTimerToast.cancel(context);
      widget.jishu = widget.jishu2;
      Fluttertoast.showToast(
          msg: "修改成功!",
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
          msg: "修改失败!",
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
