
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/jishu/jishudetail/JishuDeatilWidget.dart';
import 'package:xixi/jishu/search/JishuList/JishuListWidget.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/jishuhttpservice/JishuService.dart';
import 'package:xixi/service/util/ProgressDialogAndTImerToast.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/method/MyTools.dart';
import 'package:xixi/tools/plugins/NetworkListener.dart';

class SearchJSOrSkillWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchJSOrSkillWidgetState();
  }
}

class SearchJSOrSkillWidgetState extends State<SearchJSOrSkillWidget>{

  FocusNode focusNode = FocusNode();
  String searchText = '';              //搜索框的内容
  @override
  Widget build(BuildContext context) {

    /*
      默认是 一个搜索框 然后下面是一个 搜索按钮
      输入内容  点击搜索 查询
      查找有结果了  就跳转结果显示界面   查找不到那么这个widget重新构建   变成一个搜索框   然后下面是一句话“信息不存在”
      查找不存在时   用户只要改变搜索输入框内容 那么界面就恢复为默认
     */

    return Scaffold(
      appBar: new BaseViewBar(
          childView: new BaseTitleBar(
            "搜索",
            null,
            leftIcon: Icons.arrow_back_ios,
            rightText: "",
            rightClick: () {
//              print("点击了干嘛啊。。。哦");
            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),
      body:  Column(
        children: <Widget>[

          SizedBox(height: 60.0),

          Container(
            height: 80,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextField(
                    focusNode: focusNode,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
//                        icon: Icon(Icons.search),
                        hintText: '请输入 技术QQ / 语言技术栈',
                        hintStyle: TextStyle(
                            fontFamily: 'MaterialIcons', fontSize: 16),
                        contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        filled: true,
                        fillColor: Colors.black12),

                    onChanged: (text){
                      searchText = text;
                    },

                  ),
                ),


              ],
            ),
          ),
          SizedBox(height: 40.0),
          buildSearchButton(context)
       ]
      ),
    );

  }

  Align buildSearchButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '搜索',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Color(0xe085c2f7),
          onPressed: () {

            doSearch();
            //搜索的是qq


          },
          shape: StadiumBorder(),
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

  void doSearch() async {

    focusNode.unfocus();
    if(searchText==null||searchText.isEmpty){
      return;
    }

    bool isSearchQQ = false;
    if(MyTools.isInteger(searchText)){
      isSearchQQ = true;
    }

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

    if(isSearchQQ){
      Jishu jishu = await JishuService.getInstance().getJishuByQQ(searchText);
      if(jishu==null){
        progressDialogAndTimerToast.cancel(context);
        Fluttertoast.showToast(
            msg: "该技术不存在!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else if(jishu.qq.compareTo("")==0){
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
            builder: (context) => JishuDetailWidget(jishu: jishu)));
      }


      //搜索语言技术栈
    }else{

      List<Jishu> jishus = await JishuService.getInstance().getJishuListBySkill(searchText);
      if(jishus==null){

        progressDialogAndTimerToast.cancel(context);

        Fluttertoast.showToast(
            msg: "无对应技术信息!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else if(jishus.isEmpty||jishus.length==0){
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
            builder: (context) => JishuListWidget(jishus: jishus)));
      }

    }


  }

}
