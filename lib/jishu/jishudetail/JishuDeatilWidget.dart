
/*
  某技术详细信息
 */

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';

import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/bean/VoteDetail.dart';
import 'package:xixi/jishu/jishudetail/vote_jishu_dialog/VoteJishuDialog.dart';
import 'package:xixi/jishu/jishudetail/vote_like_button.dart';
import 'package:xixi/jishu/vote/VoteDetailListWidget.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/MyUITools/RowLine.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';
import 'package:xixi/ui/w_pop/textitem_pop.dart';

import 'JishuInfoChangeDialog/JishuInfouChangeDialog.dart';

class JishuDetailWidget extends StatefulWidget{

  Jishu jishu;

  JishuDetailWidget({Key key, this.jishu}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JishuDetailWidgetState(jishu);
  }


}

class JishuDetailWidgetState extends State<JishuDetailWidget> {

  Jishu jishu;
  JishuDetailWidgetState(this.jishu);

//  Jishu jishu = Jishu(
//      "1348247",
//      "lwh134827",
//      10,
//      3,
//      "顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶",
//      "商单",
//      "java 前端 sql");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (
        Scaffold(
          appBar: new BaseViewBar(
              childView: new BaseTitleBar(
                "技术信息",
                null,
                leftIcon: Icons.arrow_back_ios,
                rightText: "",
//                rightClick: () {
//                  print("点击了干嘛啊。。。哦");
//                },
              ),
              preferredSize: Size.fromHeight(50.0)
          ),
          body: Form(

            child: ListView(

              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
//                  height: kToolbarHeight,
                height: 8,
                ),

                buildQQText(),
                SizedBox(height: 30.0),
                buildWXTextField(),
                SizedBox(height: 20),
                 buildYesOrNo(),
                SizedBox(height: 25.0),
                buildSkillTextField(),
                SizedBox(height: 30.0),
                buildLabelTextField(),
                SizedBox(height: 30.0),
//                buildInfoTextField(),
//                SizedBox(height: 60.0),
               // buildSubmitButton(context),
              ],

            ),
          ),

        )
    );
  }

  Center buildQQText() {
    Size size = MediaQuery
        .of(context)
        .size;
    Gradient gradient = LinearGradient(
        colors: [Colors.blueAccent, Colors.greenAccent]);
    Shader shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height));
    return Center(
      child: TextItemPop(text:jishu.qq,action: "",shader: shader,fontsize: 28,),
//      child: Text(
//        "扣扣: " + jishu.qq,
//        style: TextStyle(
//          fontSize: 28,
//          foreground: Paint()
//            ..shader = shader,
//        ),
//      ),
    );
  }


  Widget buildWXTextField() {
    return RowLine(
        Icons.chat, (jishu.wx==null||jishu.wx.isEmpty)?"无":jishu.wx, describe: "微信", isShowBottomLine: true,
        leftfontSize:18,rightfontSize: 16,
      click: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_){
              return JishuInfouChangeDialog(jishu,1);
            });
      },
    );
  }



  Widget buildSkillTextField() {
    return RowLine(
      Icons.build, (jishu.skill==null||jishu.skill.isEmpty)?"无":jishu.skill, describe: "擅长", isShowBottomLine: true,
      leftfontSize:18,rightfontSize: 16,
      click: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_){
              return JishuInfouChangeDialog(jishu,2);
            });
      },
    );
  }

  Widget buildLabelTextField() {
    return RowLine(
      Icons.label,(jishu.label==null||jishu.label.isEmpty)?"无":jishu.label, describe: "标签", isShowBottomLine: true,
      leftfontSize:18,rightfontSize: 16,
      click: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_){
              return JishuInfouChangeDialog(jishu,3);
            });
      },
    );
  }

  Widget buildInfoTextField() {
    return RowLine(
      Icons.info, (jishu.info==null||jishu.info.isEmpty)?"无":jishu.info, describe: "其他", isShowBottomLine: true,
      leftfontSize:18,rightfontSize: 16,
      click: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_){
              return JishuInfouChangeDialog(jishu,4);
            });
      },
    );
  }

  Container buildSubmitButton(BuildContext context) {
    return Container(
      height: 45.0,
      width: 250.0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        //使用GestureDetector包裹Container，发现在Container内容为空的区域点击时，捕捉不到onTap点击事件。
        child: Center(
          child: Text(
            '修改',
            style: Theme
                .of(context)
                .primaryTextTheme
                .headline,

          ),
        ),
        onTap: () {
          print("点击我了");
        },
      ),

      /// 实现渐变色的效果
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular((20.0)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(26, 155, 214, 1),
            Color.fromRGBO(54, 209, 193, 1)
          ],
        ),
      ),
    );
  }




  Widget buildYesOrNo(){

    String text = "已投票靠谱";
    switch(jishu.yesorno){
      case -1:
        text = "已投票不靠谱";
        break;
      case 0:
        text = "未投票";
        break;
    }

    return Container(
      height: 80,
      padding:  EdgeInsets.only(left: 30,right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                doVoteDetail();
              },
              child:IconAndBottomText(iconData:Icons.favorite,iconColor:Colors.red,iconSize:38,text:jishu.yes.toString()+"名客服觉得靠谱",fontsize: 12,click: (){
              },) ,
            ),

          Expanded(
            flex: 1,
            child:Padding(
              padding: EdgeInsets.only(top: 5,bottom: 10),
              child: Column(

                children: <Widget>[
                  Text(text),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  voteButton(),
                ],
              ),
            )

          ),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
              onTap: (){
                doVoteDetail();
              },
              child:   IconAndBottomText(iconData:Icons.thumb_down,iconSize:38,iconColor:Colors.green,text:jishu.no.toString()+"名客服觉得不靠谱",fontsize: 12,click: (){

              },),
            )

//            IconAndBottomText(),
          ],
        ),
    );

  }

  Container voteButton() {
    return Container(
//      height: 45.0,
      width: 100.0,

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        //使用GestureDetector包裹Container，发现在Container内容为空的区域点击时，捕捉不到onTap点击事件。
        child: Center(
          child: Text(
            '投票',
            style: Theme
                .of(context)
                .primaryTextTheme
                .headline,

          ),
        ),
        onTap: () async{
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_){
                return VoteJishuDialog(jishu);
              });
          setState(() {

          });
        },
      ),

      /// 实现渐变色的效果
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular((20.0)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(26, 155, 214, 1),
            Color.fromRGBO(54, 209, 193, 1)
          ],
        ),
      ),
    );
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


    void doVoteDetail() async {


      bool isInternetAccess = await NetworkListener.getINstance().isInternetAccess();
      if(isInternetAccess==false){

        Fluttertoast.showToast(
            msg: "当前无可用网络!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }

      progressDialogAndTimerToast = ProgressDialogAndTimerToast(HttpUtil.awaitServerTime,"error,请稍后再试!");
      progressDialogAndTimerToast.begin(context);


        List<VoteDetail> voteDetails = await JishuService.getInstance().getVoteDetailListByJishuQQ(jishu.qq);
        if(voteDetails==null){

          progressDialogAndTimerToast.cancel(context);

          Fluttertoast.showToast(
              msg: "无对应信息!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else if(voteDetails.isEmpty||voteDetails.length==0){
          progressDialogAndTimerToast.cancel(context);
          Fluttertoast.showToast(
              msg: "服务器飞走了,请稍后再试!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }else {
          progressDialogAndTimerToast.cancel(context);

          Navigator.push(context, MaterialPageRoute(
              builder: (context) => VoteDetailListWidget(voteDetails: voteDetails,)));
        }


    }


}


