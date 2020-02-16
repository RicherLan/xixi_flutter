
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:xixi/service/HttpRoutePath.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';




void main() async {

  String res = await UserService.getInstance().updatePassword("1号客服", "123456","123");
  print(res+"   222222222222");

}

class UserService{

  static UserService userService=null;

  static UserService getInstance(){
    if(userService==null){
      userService = UserService();
    }
    return userService;
  }

  //返回 message: ok  password error     username error     error
  //     security：
  Future<String> login(String username,String password) async {

    Map<String,String> map = Map();                         //第2种方式
    map["username"] = username;
    map["password"] = password;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_LOGIN,data:map);
    String message = "error";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
        message = data['message'];
        HttpUtil.securityStr = data['security'];
        Service.loginUsername = username;
        if(message.compareTo("ok")==0){

          MySharePerferenceAPI.setSharePerferenceString("username", username);

          MySharePerferenceAPI.setSharePerferenceString("password", password);
          MySharePerferenceAPI.setSharePerferenceString("kiplogin", "yes");
        }else{
          MySharePerferenceAPI.setSharePerferenceString("kiplogin", "no");
        }

    }

    return message;

  }


  /*
    返回 message:ok     oldpassword error     error
   */
  Future<String> updatePassword(String username,String oldpassword,String newpassword) async{

    Map<String,String> map = Map();                         //第2种方式
    map["username"] = username;
    map["oldpassword"] = oldpassword;
    map["newpassword"] = newpassword;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_UPDATE_PASS,data:map);
    String message = "error";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
    }

    return message;

  }



}

