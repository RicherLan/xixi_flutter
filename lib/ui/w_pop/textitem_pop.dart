

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'magic_pop.dart';

class TextItemPop extends StatefulWidget {
  final String text;
  final String action;
  final Shader shader;
  final Color backcolor;
  final double fontsize;


  TextItemPop({this.fontsize = 16,this.shader,this.backcolor=Colors.white,this.text, this.action});


 @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextItemPopState();
  }
}

class TextItemPopState extends State<TextItemPop> {



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return MagicPop(
      onValueChanged: (int value) {
        switch (value) {
          case 0:
            Clipboard.setData(new ClipboardData(text: widget.text));
            break;
          case 3:
            break;
        }
      },
      pressType: PressType.longPress,
      actions: ['复制',  '收藏', '感悟'],
      child: new Container(
        width: widget.text.length > 24 ? (width - 66) - 100 : null,
//        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
//          color: widget.isMyself ? Color(0xff98E165) : Colors.white,
          color: widget.backcolor,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
//        margin: EdgeInsets.only(right: 7.0),
        child:Text(
          widget.text,
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          style: TextStyle(
              fontSize: widget.fontsize, fontWeight: FontWeight.w600,foreground: Paint()
            ..shader = widget.shader,),
        ) ,
      ),
    );
  }
}
