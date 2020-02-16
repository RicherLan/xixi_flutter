

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/tools/method/MySharePerferenceAPI.dart';

class StorageManager {
  /// app全局配置
  static SharedPreferences sharedPreferences;

  static String kiplogin = "no";

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
    getUserState();
  }

  static getUserState() async{
    kiplogin = await sharedPreferences.getString("kiplogin");
    if(kiplogin==null){
      kiplogin = "no";
    }

    Service.loginUsername = await sharedPreferences.getString("username");
    if(Service.loginUsername==null){
      Service.loginUsername = "";
    }

  }


}