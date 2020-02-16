/*
  搜索语言    返回技术列表
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/bean/VoteDetail.dart';
import 'package:xixi/jishu/jishudetail/JishuDeatilWidget.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/MyUITools/RowLine.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';
import 'package:xixi/ui/w_pop/textitem_pop.dart';

import 'VoteDetailDialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: VoteDetailListWidget(),
    );
  }
}

class VoteDetailListWidget extends StatefulWidget {
  List<VoteDetail> voteDetails;

  VoteDetailListWidget({Key key, this.voteDetails}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VoteDetailListWidgetState(voteDetails);
  }
}


class VoteDetailListWidgetState extends State<VoteDetailListWidget> {
  List<VoteDetail> voteDetails;

  VoteDetailListWidgetState(this.voteDetails);




  @override
  Widget build(BuildContext context) {

        if(voteDetails==null){
          voteDetails = List<VoteDetail>();

        VoteDetail jishu = VoteDetail("1号客服", "2371331920","1348270542", 1,"很靠谱 有耐心 报价低");
        voteDetails.add(jishu);

          VoteDetail jishu2 = VoteDetail("2号客服", "11313131","1348270542", 1,"性格好");
          VoteDetail jishu3 = VoteDetail("3号客服", "165461323","1348270542", -1,"学生 技术不行");
          VoteDetail jishu4 = VoteDetail("4号客服", "4984916511","1348270542", -1,"甩单 私接");
          VoteDetail jishu5 = VoteDetail("5号客服", "8946151311","1348270542", -1,"不好");

          voteDetails.add(jishu2);
          voteDetails.add(jishu3);
          voteDetails.add(jishu4);
          voteDetails.add(jishu5);

    }


    // TODO: implement build
    return Scaffold(
        appBar: new BaseViewBar(
            childView: new BaseTitleBar(
              "评价详情",
              Color(0xffb5dbf7),
              leftIcon: Icons.arrow_back_ios,
              rightText: "",
              rightClick: () {

              },
            ),
            preferredSize: Size.fromHeight(50.0)),

          //body:buildQQText() ,

        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,//要求内部的小部件填充满横轴
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "技术qq : ",
                  style: TextStyle(fontSize: 20),
                ),
                buildQQText(),
              ],
            ),

            Expanded(
              child: Container(

                child:MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.separated(
                    itemCount: voteDetails.length,
                    itemBuilder: (context, index) {
                      return _buildItem(voteDetails[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        color: Colors.black26,
                      );
                    },
                  ),
                ),),
            )

          ],
        )


    );
  }


  Widget buildQQText() {
    Size size = MediaQuery
        .of(context)
        .size;
    Gradient gradient = LinearGradient(
        colors: [Colors.blueAccent, Colors.greenAccent]);
    Shader shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height));
    return Container(
      height: 80,

      child:Center(
        child: TextItemPop(text:"1348270542",action: "",shader: shader,fontsize: 28,),
//      child: Text(
//        "扣扣: " + jishu.qq,
//        style: TextStyle(
//          fontSize: 28,
//          foreground: Paint()
//            ..shader = shader,
//        ),
//      ),
      )

    );
  }

  Widget _buildItem(VoteDetail voteDetail) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_){
              return VoteDetailDialog(voteDetail);
            });
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

                        GestureDetector(
                          onLongPress: (){
//                            Clipboard.setData(new ClipboardData(text: jishu.label));
//                            Fluttertoast.showToast(
//                                msg: "已复制!",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.CENTER,
//                                timeInSecForIos: 3,
//                                backgroundColor: Colors.black,
//                                textColor: Colors.white,
//                                fontSize: 16.0
//                            );
                          },
                          child: Container(

                                 child: Text(
                                   voteDetail.kefuname,
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),

                          ) ,
                        ),


                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "qq: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextItemPop(text:voteDetail.kefuqq,action: "",backcolor: Color(0xff98E165),),
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

                                    Clipboard.setData(new ClipboardData(text: voteDetail.kefuqq));
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
//                            Clipboard.setData(new ClipboardData(text: jishu.skill));
//                            Fluttertoast.showToast(
//                                msg: "已复制!",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.CENTER,
//                                timeInSecForIos: 3,
//                                backgroundColor: Colors.black,
//                                textColor: Colors.white,
//                                fontSize: 16.0
//                            );
                          },
                          child:  Container(

                                    child: Text(voteDetail.yesorno==1?"认为该技术 靠谱":"认为该技术 不靠谱",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),


                          ),
                        ),

                        SizedBox(height: 5,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "原因: ",
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                    voteDetail.info,
                                    maxLines: 3,
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

