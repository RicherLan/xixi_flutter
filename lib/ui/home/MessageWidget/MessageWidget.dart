import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';

class MessageWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MMessageWidgetState();
  }

}

class MMessageWidgetState extends State<MessageWidget>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new BaseViewBar(
          childView: new BaseTitleBar(
            "消息",
            null,
//            leftIcon: Icons.arrow_back_ios,
            rightText: "",
            rightClick: () {
//              print("点击了干嘛啊。。。哦");
            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),
    );
  }
}