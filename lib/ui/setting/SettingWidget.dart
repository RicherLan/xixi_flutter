
/*
  设置界面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xixi/service/APPRoutePath.dart';
import 'package:xixi/tools/MyUITools/BaseTitleBar.dart';
import 'package:xixi/tools/MyUITools/BaseViewBar.dart';
import 'package:xixi/tools/MyUITools/RowLine.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: SettingWidget(),
    );
  }

}

class SettingWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingWidgetState();
  }
}

class SettingWidgetState extends State<SettingWidget>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new BaseViewBar(
          childView: new BaseTitleBar(
            "设置",
            null,
            leftIcon: Icons.arrow_back_ios,
            rightText: "",
            rightClick: () {
              print("点击了干嘛啊。。。哦");
            },
          ),
          preferredSize: Size.fromHeight(50.0)
      ),

      body: Container(

        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context,index){
              if(index==0){
                return SizedBox(height: 50,);
              }else if(index==1){
                return RowLine(Icons.edit,"修改密码",describe:"",isShowBottomLine:true,
                  click: (){
                    Navigator.pushNamed(context, APPRoutePath.UpdatePasswordWidget);
                    }
                    );
              }else if(index==2){
                return RowLine(Icons.home,"退出登录",describe:"",isShowBottomLine:true,
                    click: (){
                      MySharePerferenceAPI.setSharePerferenceString("kiplogin", "no");
                      Navigator.of(context).pushNamedAndRemoveUntil(APPRoutePath.LoginWidget,ModalRoute.withName(APPRoutePath.LoginWidget));

                    }
                );
              }
              else if(index==3){
                return RowLine(Icons.exit_to_app,"退出软件",describe:"",isShowBottomLine:true,
                    click: (){
                      SystemNavigator.pop();
                    }
                );;
              }
              else if(index==3){
//                return;
              }
            }
        ),

      ),
    );
  }



}