
/*
   自定义的行
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RowLine extends StatelessWidget{

  IconData iconData;             //最左边的头像
  String title;                    //头像右边的字
  String describe;                  //最右边的字
  bool isShowBottomLine;           //是否底下跟着分割线

  double lineheight;
  double leftfontSize ;
  double rightfontSize;
  double bottomLineHeight;

  final VoidCallback click;              //点击事件



  RowLine(this.iconData,this.title,{this.lineheight=50,this.bottomLineHeight = 4,this.describe,this.isShowBottomLine=true,this.click,this.leftfontSize=16,this.rightfontSize=14});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _cell();
  }

  Widget _cell() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: click,
      child: new Container(
//          color: Color(0xFF191919),
        height: lineheight,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.all(0.0),
                height: (isShowBottomLine ? lineheight-bottomLineHeight : lineheight),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child:  new Container(
                          margin: new EdgeInsets.only(left: 15.0),
                          child: new Row(
                            children: <Widget>[
                              new Icon(iconData, color: Color(0xFF777777)),
                              Expanded(
                                child: new Container(
                                  margin: new EdgeInsets.only(left: 15.0),

                                  child: GestureDetector(
                                    onLongPress: (){
                                      Clipboard.setData(new ClipboardData(text: title));
                                      Fluttertoast.showToast(
                                          msg: "已复制!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 3,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    },

                                    child: Text(title, overflow: TextOverflow.ellipsis,style: TextStyle(color: Color(0xFF777777), fontSize: leftfontSize)),

                                  )


                                    ) ,
                              )


                            ],
                          ),
                        ),
                      )
                     ,
                      new Container(
                        child: new Row(
                          children: <Widget>[
                            new Text(describe, style: TextStyle(color: Color(0xFFD5A670), fontSize: rightfontSize)),
                            new Icon(Icons.keyboard_arrow_right, color: Color(0xFF777777)),
                          ],
                        ),
                      ),
                    ]
                )
            ),

            _bottomLine(isShowBottomLine),

          ],
        ),
      ),
    );
  }

  Widget _bottomLine(bool isShowBottomLine) {
    if (isShowBottomLine) {
      return new Container(
          margin: new EdgeInsets.all(0.0),
          child: new Divider(
            height: bottomLineHeight,
//                color: Colors.black
          ),
          padding: EdgeInsets.only(left: 15.0, right: 15.0)
      );
    }
    return Container();
  }

}

