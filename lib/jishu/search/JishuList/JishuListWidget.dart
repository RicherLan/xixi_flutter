/*
  搜索语言    返回技术列表
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/jishu/jishudetail/JishuDeatilWidget.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/RowLine.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';
import 'package:xixi/ui/w_pop/textitem_pop.dart';

import 'item/JishuListItemWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: JishuListWidget(),
    );
  }
}

class JishuListWidget extends StatefulWidget {
  List<Jishu> jishus;

  JishuListWidget({Key key, this.jishus}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JishuListWidgetState(jishus);
  }
}
/*
class JishuListWidgetState extends State<JishuListWidget>{


  List<Jishu> jishus;
  JishuListWidgetState(this.jishus);

  String skillStr;       //搜索的技术



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

//    if(jishus==null){
//      jishus = List<Jishu>();
//      for(int i=0;i<15;++i){
//        Jishu jishu = Jishu("1348270542","lwh134824",10,20,"无","报价低 大单子","c++ python dart flutter java android acm");
//        jishus.add(jishu);
//      }
//    }

    /*return Container(
        child:MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.separated(
            itemCount: jishus.length,
            itemBuilder: (context, index) {
              return JishuListItemWidget(jishus[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.black26,
              );
            },
          ),
        )
    );*/



    return Scaffold(
      body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                          hintText: '\uE8b6 语言技术栈',
                          hintStyle: TextStyle(
                              fontFamily: 'MaterialIcons', fontSize: 16),
                          contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          filled: true,
                          fillColor: Colors.black12),

                      onTap: (){
                       // Navigator.pushNamed(context, APPRoutePath.SearchJSOrSkillWidget);
                      },

                    ),
                  ),

                ],
              ),
            ),

//           SizedBox(
//             height: 30,
//           ),
            Divider(
              height: 40,
              color: Colors.green,
            ),
           Expanded(
                child:MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.separated(
                    itemCount: jishus.length,
                    itemBuilder: (context, index) {
                      return JishuListItemWidget(jishus[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.black26,
                      );
                    },
                  ),
                )
            )

          ]
      )
    );

  }

}
*/

class JishuListWidgetState extends State<JishuListWidget> {
  List<Jishu> jishus;

  JishuListWidgetState(this.jishus);

  var _showNarrow = false;
  var _oldShowState = false;
  var _scrollController = ScrollController();

  bool _onNotification(ScrollNotification notification) {
    bool show = _scrollController.offset > 100;
    if (show != _oldShowState) {
      _oldShowState = show;
      setState(() {
        _showNarrow = show;
      });
    }
    return true;
  }

//  void _functionTap(int index) {
//    Navigator.push(
//      context,
//      new MaterialPageRoute(
//          builder: (context) => new SearchPage(
//            type: index,
//          )),
//    );
//  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: new BaseViewBar(
//          childView: new BaseTitleBar(
//            "动态",
//            null,
////            leftIcon: Icons.arrow_back_ios,
//            rightText: "",
//            rightClick: () {
////              print("点击了干嘛啊。。。哦");
//            },
//          ),
//          preferredSize: Size.fromHeight(50.0)
//      ),

        body: Stack(
      children: <Widget>[
        NotificationListener(
            onNotification: _onNotification,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 1.8),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return _ExpandWidget(show: !_showNarrow);
                    },
                    childCount: 1,
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 180,
                  delegate: new SliverChildBuilderDelegate(
                    (context, index) => _buildItem(jishus[index]),
                    childCount: jishus.length,
                  ),
                )
              ],
              controller: _scrollController,
            )),
        _NarrowWidget(
          show: _showNarrow,
        ),
      ],
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(progressDialogAndTimerToast!=null){
      progressDialogAndTimerToast.cancel(context);
    }
  }

  ProgressDialogAndTimerToast progressDialogAndTimerToast;
  void goJishuDetail(String jishuqq) async {


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
      return;
    }

    progressDialogAndTimerToast =
        ProgressDialogAndTimerToast(HttpUtil.awaitServerTime, "error,请稍后再试!");
    progressDialogAndTimerToast.begin(context);

    Jishu jishu = await JishuService.getInstance().getJishuByQQ(jishuqq);
    if (jishu == null) {
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (jishu.qq.compareTo("") == 0) {
      progressDialogAndTimerToast.cancel(context);
      Fluttertoast.showToast(
          msg: "服务器飞走了,请稍后再试!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
        progressDialogAndTimerToast.cancel(context);

      final res = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JishuDetailWidget(jishu: jishu)));

      setState(() {
        for(int i=0;i<jishus.length;++i){
          if(jishus[i].qq.compareTo(jishuqq)==0){
            jishus[i] = jishu;
          }
        }
      });

    }
  }

  Widget _buildItem(Jishu jishu) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        goJishuDetail(jishu.qq);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 170,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    "images/jishuPhoto.jpg",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
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
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 1,
                              child: TextItemPop(text:jishu.qq,action: "",backcolor: Color(0xff98E165),),
//                                child: Text(
//                                  jishu.qq,
////                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                                  style: TextStyle(
//                                      fontSize: 16,
//                                      fontWeight: FontWeight.w600),
//                                ),
                              ),
                              SizedBox(
                                width: 60,
                                height: 20,
                                child:  RaisedButton(
                                  child: Text(
                                    '复制',
//                                  style: ,
                                  ),
                                  color: Color(0xe085c2f7),
                                  onPressed: () {

                                    Clipboard.setData(new ClipboardData(text: jishu.qq));
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
                                  shape: StadiumBorder(),
                                ),
                              ),

                            ]),
                        SizedBox(
                          height: 5,
                        ),

                        GestureDetector(
                          onLongPress: (){
                            Clipboard.setData(new ClipboardData(text: jishu.label));
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
                          child: Container(
                            height: 40,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "标签: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(jishu.label,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ]),
                          ) ,
                        ),

                        GestureDetector(

                          onLongPress: (){
                            Clipboard.setData(new ClipboardData(text: jishu.skill));
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
                          child:  Container(
                            height: 40,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "擅长: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(jishu.skill,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ]),
                          ),
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
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    jishu.yes.toString() +
                                        "名客服标记    靠谱\n" +
                                        jishu.no.toString() +
                                        "名客服觉得不靠谱",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              )
                            ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Colors.black26,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _ExpandWidget extends StatefulWidget {
  var show = true;

  _ExpandWidget({this.show});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExpandWidgetState();
  }
}

class _ExpandWidgetState extends State<_ExpandWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.show) {
      return Stack(
        children: <Widget>[
          Image.asset('images/dongtai.jpg', fit: BoxFit.fill, height: 100),
          Positioned(
            top: 30,
            left: 0,
           child: IconButton(
              /// 左边图标，视情况而定，自己穿参数
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20,
            right: 20,
            child: GestureDetector(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    Text("请输入 技术QQ / 语言技术栈  查询"),
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: new BorderRadius.circular((5.0)),
                ),
                padding: EdgeInsets.all(8.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Container();
    }
  }
}

// ignore: must_be_immutable
class _NarrowWidget extends StatefulWidget {
  var show = false;

  _NarrowWidget({this.show});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NarrowWidgetState();
  }
}

class _NarrowWidgetState extends State<_NarrowWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.show) {
      return Stack(
        children: <Widget>[
          Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 48, 20, 15),
                color: Color(0xFF52707A),
//                color: Color(0xfff7dfde),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.search),
                        Text("请输入 技术QQ / 语言技术栈  查询"),
                      ],
                    ),
                    decoration: new BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: new BorderRadius.circular((5.0)),
                    ),
                    padding: EdgeInsets.all(8.0),
                  ) ,
                ),

              )),
        ],
        fit: StackFit.expand,
        alignment: Alignment.topCenter,
      );
    } else {
      return Container();
    }
  }
}
