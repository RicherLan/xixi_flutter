
/*
  技术列表
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/tools/MyUITools/RowLine.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Jishu jishu = Jishu("1348270542","lwh134824",10,20,"无","报价低 大单子","c语言java android Flutter",0);
    return MaterialApp(

      home: JishuListItemWidget(jishu),
    );
  }

}

class JishuListItemWidget extends StatefulWidget{

  Jishu jishu;
  JishuListItemWidget(this.jishu);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JishuListItemWidgetState();
  }


}

class JishuListItemWidgetState extends State<JishuListItemWidget>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 170,
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 10,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              "images/jishuPhoto.jpg",
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ) ,
          )
         ,
          Expanded(

            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left:20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "扣扣: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          widget.jishu.qq,
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      )

                    ]

                  ),

                  Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "标签: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              widget.jishu.label,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                        )

                      ]

                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "擅长: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                                  widget.jishu.skill,

                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        )

                      ]

                  ),
                  Divider(
                    height: 2,
                    color: Colors.green,
//                color: Colors.black
                  ),
                  Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "评价: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              widget.jishu.yes.toString()+"名客服标记靠谱\n"+widget.jishu.no.toString()+"名客服觉得不靠谱",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        )

                      ]

                  ),

                ],
              ),
            ),

          ),

        ],
      ),
    );
  }

}


