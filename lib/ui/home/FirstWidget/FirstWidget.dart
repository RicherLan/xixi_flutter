
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';

import 'First_oneWidget.dart';

class FirstWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {

    return FirstWidgetState();
  }

}


class FirstWidgetState extends State<FirstWidget>{

  String textString = "";      //搜索框信息

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: new BaseViewBar(
            childView: new BaseTitleBar(
              "问道阁",
                Color(0xff213039),
//              leftIcon: Icons.arrow_back_ios,
              rightText: "",
//              rightClick: () {
//                print("点击了干嘛啊。。。哦");
//              },
            ),
            preferredSize: Size.fromHeight(50.0)
        ),
//      backgroundColor: Color(0xff213039),
      body:Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
//            color: Color(0xff213039),
            height: 40,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                      Icon(Icons.search),
                      Expanded(
                        flex: 1,
                        child:  TextField(
                          focusNode: focusNode,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                              hintText: '技术账号 / 语言技术栈',
                              hintStyle: TextStyle(
                                  fontFamily: 'MaterialIcons', fontSize: 16),
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              filled: true,
                              fillColor: Colors.white),

                          onTap: (){
                            focusNode.unfocus();
                            Navigator.pushNamed(context, APPRoutePath.SearchJSOrSkillWidget);
                          },

                        ),
                      )

                    ],
                ),
            ),
          Expanded(
            flex: 1,
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: 50),

                      child: TabBar(
                          unselectedLabelColor: Colors.black12,
                          labelColor: Colors.black87,

                          indicatorColor: Colors.black87,
                          tabs: <Widget>[Tab(text: '修仙之路' ), Tab(text: '悟道之路')]
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          physics: ClampingScrollPhysics(),          //android下滑动到边界  微光效果
                          children: <Widget>[

                            First_oneWidget(),

                            Center(
                              child: Text('电视'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      )
    );
  }

}