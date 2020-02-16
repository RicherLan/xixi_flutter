
/*
  sharePerference的封装操作
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xixi/config/storage_manager.dart';

class MySharePerferenceAPI{

  static void setSharePerferenceString(String key,String value) async{

    StorageManager.sharedPreferences.setString(key, value);

  }

  static void setSharePerferenceInt(String key,int value) async{
    StorageManager.sharedPreferences.setInt(key, value);
  }

  static void setSharePerferenceDouble(String key,double value) async{
    StorageManager.sharedPreferences.setDouble(key, value);
  }


  static void setSharePerferenceBool(String key,bool value) async{
    StorageManager. sharedPreferences.setBool(key, value);
  }

  static Future<String>  getSharePerferenceString(String key) async{

    var value = StorageManager.sharedPreferences.getString(key);
    return value;
  }


}

