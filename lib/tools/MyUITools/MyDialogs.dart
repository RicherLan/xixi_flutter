
/*
  常用dialog
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xixi/service/APPRoutePath.dart';

class MyDialogs{


  /*
    身份过期   或者账号密码错误等    重新登录
   */
  static void showNeedLoginDialog(BuildContext context,String text){


    showDialog<Null>(
      context: context, // BuildContext对象
      barrierDismissible: false, // 屏蔽点击对话框外部自动关闭
      builder: (_) => WillPopScope(
          child:AlertDialog(
            title: Text('身份信息'),
            content:Text(text),
            actions:<Widget>[
              FlatButton(
                child: Text('重新登录'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context,APPRoutePath.LoginWidget);
                },
              ),
              FlatButton(
                child: Text('取消'),
                onPressed: (){
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
              ),
            ],
//            backgroundColor:Colors.yellowAccent,
            elevation: 20,
//            semanticLabel:'哈哈哈哈',
            // 设置成 圆角
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        onWillPop: () async {
          return Future.value(false);
        },
      ),
    );

  }


}