
/*

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/jishu/jishudetail/JishuInfoChangeDialog/JishuInfouChangeDialog.dart';
import 'package:xixi/service/APPRoutePath.dart';

class First_oneWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return First_oneWidgetState();
  }

}

class First_oneWidgetState extends State<First_oneWidget>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),

      child: Column(

        children: <Widget>[
          SizedBox(height: 30,),
          Padding(
              padding:EdgeInsets.only(left: 25, right: 25),
              child:Row(
                children: <Widget>[
                  myCard("images/firstPage/1.jpg", "添加技术", "练气",
                      (){
                        Navigator.pushNamed(context, APPRoutePath.Add_jishuQQWidget);
                      }),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  myCard("images/firstPage/2.jpg", "搜索技术", "筑基",
                          (){
                          Navigator.pushNamed(context, APPRoutePath.SearchJSOrSkillWidget);
                        }),
                ],
              ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding:EdgeInsets.only(left: 25, right: 25),
            child:Row(
              children: <Widget>[
                myCard("images/firstPage/3.jpg", "我要报账", "金丹",
                    (){
                      Fluttertoast.showToast(
                          msg: "This is Center Short Toast",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                myCard("images/firstPage/4.jpg", "建议留言", "元婴",(){}),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding:EdgeInsets.only(left: 25, right: 25),
            child:Row(
              children: <Widget>[
                myCard("images/firstPage/5.jpg", "我的好友", "凝体",(){}),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                myCard("images/firstPage/6.jpg", "我的群聊", "乘鼎",(){}),
              ],
            ),
          ),

          SizedBox(height: 30,),
          Padding(
            padding:EdgeInsets.only(left: 25, right: 25),
            child:Row(
              children: <Widget>[
                myCard("images/firstPage/7.jpg", "不存在了", "劫变",(){}),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                myCard("images/firstPage/8.jpg", "真的没了", "化真",(){}),
              ],
            ),
          ),
        ],

      ),


    );
  }



  Widget myCard(String imagepath,String title,String info,VoidCallback click ){
    var width = MediaQuery.of(context).size.width;
    var cardWidth = (width-40-40)/2;
    return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(

          width: cardWidth,
          height: cardWidth*1.4,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(3.0, 6.0),
                blurRadius: 10.0)
          ]),
          child:GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:click,
            child: Stack(

              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(imagepath, fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "SF-Pro-Text-Regular")),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 12.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          decoration: BoxDecoration(
//                              color: Colors.blueAccent,
                              color:Color(0xffa5d7ef),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(info,
                              style: TextStyle(color: Color(0xff213442))),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )

          ),

    );
  }


}