import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';

class MineWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MineWidgetState();
  }

}

class MineWidgetState extends State<MineWidget>{

    @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new BaseViewBar(
          childView: new BaseTitleBar(
            "我的",
            null,
//            leftIcon: Icons.arrow_back_ios,
            rightText: "",
//            rightClick: () {
//              print("点击了干嘛啊。。。哦");
//            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),

      body: Container(
//        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        child: new ListView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _topView(Service.loginUsername, "********");
            } else if (index == 1) {
              return _cell(index, Icons.account_circle, "封位","客服", true);
            } else if (index == 2) {
              return _cell(index, Icons.color_lens, "收藏", "", true);
            }  else if (index == 3) {
              return _cell(index, Icons.collections, "相册", "", false);
            } else if (index == 4) {
              return _spaceView();
            } else if (index == 5) {
              return _cell(index, Icons.help, "帮助", "", true);
            }  else if (index == 6) {
              return _cell(index, Icons.settings, "设置", "", false);
            } else {
              return new Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
              );
            }
          },
          itemCount: 6 + 1,
        ),
      ),

    );
  }


    Widget _cell(int row, IconData iconData, String title, String describe, bool isShowBottomLine) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          switch (row) {
            case 0:
              print("$row -- $title");
              break;
            case 1:
              print("$row -- $title");
              break;
            case 2:
              print("$row -- $title");
              break;
            case 3:
              print("$row -- $title");
              break;
            case 4:
              print("$row -- $title");
              break;
            case 5:
              print("$row -- $title");
              break;
            case 6:                      //设置
              Navigator.pushNamed(context, APPRoutePath.SettingWidget);
              break;
          }
        },
        child: new Container(
//          color: Color(0xFF191919),
          height: 50.0,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                  margin: new EdgeInsets.all(0.0),
                  height: (isShowBottomLine ? 49.0 : 50.0),
                  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(left: 15.0),
                          child: new Row(
                            children: <Widget>[
                              new Icon(iconData, color: Color(0xFF777777)),
                              new Container(
                                margin: new EdgeInsets.only(left: 15.0),
                                child: new Text(title, style: TextStyle(color: Color(0xFF777777), fontSize: 16.0)),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            children: <Widget>[
                              new Text(describe, style: TextStyle(color: Color(0xFFD5A670), fontSize: 14.0)),
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
                height: 1.0,
//                color: Colors.black
            ),
            padding: EdgeInsets.only(left: 15.0, right: 15.0)
        );
      }
      return Container();
    }

    Widget _spaceView() {
      return Container(
        height: 10.0,
//        color: Colors.black,
      );
    }

    Widget _topView(String name, String phone) {
      return new GestureDetector(
        onTap: () {
          print("修改头像、姓名、电话");
        },
        child:Column(
          children: <Widget>[
            new Container(
              height: 90.0,
              margin: new EdgeInsets.only(top: 20.0),
//              color: Colors.yellow,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                        padding: new EdgeInsets.only(left: 15.0),
                        child: new Card(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(new Radius.circular(35.0))
                          ),
                          child: ClipOval(
                              child: Image.asset(
                                "images/jishuPhoto.jpg",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ) ,
                            )
                        )
                    ),
                    Expanded(
                      flex: 1,
                      child:Container(
                        margin: new EdgeInsets.only(left: 8.0, top: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            new Text(name, style: TextStyle(color: Color(0xFF777777), fontSize: 18.0), textAlign: TextAlign.left),
                            new Text(phone, style: TextStyle(color: Color(0xFF555555), fontSize: 12.0), textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),

                    new Container(
                      child: new Icon(Icons.keyboard_arrow_right, color: Color(0xFF777777)),
//                      margin: new EdgeInsets.only(left: MediaQuery.of(context).size.width/ 2 - 15.0),
                    )
                  ]
              ),
            ),
            SizedBox(height: 50,)
          ],
        )

      );
    }



}