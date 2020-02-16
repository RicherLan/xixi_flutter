
import 'dart:convert';

import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/bean/Vote.dart';
import 'package:xixi/bean/VoteDetail.dart';
import 'package:xixi/service/HttpUtil.dart';
import 'package:xixi/service/Service.dart';

import '../HttpRoutePath.dart';



void main() async {

//   List<Jishu> jishus = await JishuService.getInstance().GetOnlyYesJishus();
//   if(jishus==null||jishus.length==0){
//     print("不存在");
//   }else{
//     for(Jishu jishu in jishus){
//       print(jishu.toJson());
//     }
//   }

  Vote vote = Vote("1号客服","1348270542",-1,"很靠谱");
    String res = await JishuService.getInstance().voteJishu(vote);
    print(res);


}

class JishuService{

  static JishuService userService=null;

  static JishuService getInstance(){
    if(userService==null){
      userService = JishuService();
    }
    return userService;
  }


  /*
    搜索技术qq
    服务器返回  message:  ok    该技术不存在!
          jishu对象(若message为ok)


    该函数返回   jishu对象    若null对象 ，说明改技术不存在,若一个Jishu.structByNULL()，说明请求服务器出错
   */

  Future<Jishu> getJishuByQQ(String qq) async{

    Map<String,String> map = Map();                         //第2种方式
    map["qq"] = qq;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_QQ,data:map);
    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){
        var jsonmap = json.decode(data['jishu']);
        Jishu jishu = Jishu.fromJson(jsonmap);
        return jishu;
      }else{
        return null;
      }

    }

    return Jishu.structByNULL();

  }

  /*
    搜索技术wx
    返回  message:  ok    该技术不存在!
          jishu对象(若message为ok)
   */

  Future<Jishu> getJishuByWX(String wx) async{

    Map<String,String> map = Map();                         //第2种方式
    map["wx"] = wx;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_WX,data:map);
    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){
        var jsonmap = json.decode(data['jishu']);
        Jishu jishu = Jishu.fromJson(jsonmap);
        return jishu;
      }else{
        return null;
      }

    }

    return Jishu.structByNULL();

  }

  /*
    添加技术
    返回  message: ok    error       has existed
   */
  Future<String> addJishu(Jishu jishu) async{

    Map<String,String> map = Map();
    map["kefuusername"] = Service.loginUsername;
    map["jishu"] = json.encode(jishu.toJson());

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_ADD_JISHU,data:map);
    String message = "error";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];

    }

    return message;

  }

  /*
   补充技术信息    就是修改技术信息
    返回  message: ok    error       not exist
   */
  Future<String> supplyJishu(Jishu jishu) async{

    Map<String,String> map = Map();
    map["kefuusername"] = Service.loginUsername;
    map["jishu"] = json.encode(jishu.toJson());

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_SUPPLY_JISHU,data:map);
    String message = "error";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];

    }

    return message;

  }

  /*
    搜索技术语言栈   获得技术里列表

    服务器返回  message:  ok    该技术不存在!
          jishu对象(若message为ok)


    该函数返回   list<jishu>对象    若null对象 ，说明改技术不存在,若一个空list即List()，说明请求服务器出错

   */
  Future<List<Jishu> > getJishuListBySkill(String skill) async{

    Map<String,String> map = Map();
    map["skill"] = skill;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_SKILL,data:map);
    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<Jishu> jishus = new List();
        for(dynamic jsonstr in data['jishus']){
        //  var jsonmap = json.decode(data['jishu']);
          Jishu jishu = Jishu.fromJson(jsonstr);
          jishus.add(jishu);
        }
        return jishus;
      }else{
        return null;
      }

    }

    return List<Jishu>();

  }


  /*
    获得只要好评的技术
    返回  message:  ok    该技术不存在!
          技术的jsonarray
   */
  Future<List<Jishu> > GetOnlyYesJishus() async{

    Map<String,String> map = Map();

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_ONLY_YES,data: map);

    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<Jishu> jishus = new List();
        for(dynamic jsonstr in data['jishus']){
          //  var jsonmap = json.decode(data['jishu']);
          Jishu jishu = Jishu.fromJson(jsonstr);
          jishus.add(jishu);
        }
        return jishus;
      }

    }

    return null;

  }


  /*
    获得只有差评的技术
    返回  message:  ok    该技术不存在!
          技术的jsonarray
   */
  Future<List<Jishu> > GetOnlyNoJishus() async{

    Map<String,String> map = Map();

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_ONLY_NO,data: map);

    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<Jishu> jishus = new List();
        for(dynamic jsonstr in data['jishus']){
          //  var jsonmap = json.decode(data['jishu']);
          Jishu jishu = Jishu.fromJson(jsonstr);
          jishus.add(jishu);
        }
        return jishus;
      }

    }

    return null;

  }

  /*
    获得好评票数多于差评票数的技术
    返回  message:  ok    该技术不存在!
          技术的jsonarray
   */
  Future<List<Jishu> > GetYesJishus() async{

    Map<String,String> map = Map();

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_YES,data: map);

    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<Jishu> jishus = new List();
        for(dynamic jsonstr in data['jishus']){
          //  var jsonmap = json.decode(data['jishu']);
          Jishu jishu = Jishu.fromJson(jsonstr);
          jishus.add(jishu);
        }
        return jishus;
      }

    }

    return null;

  }

  /*
    获得差评票数多于好评票数的技术
    返回  message:  ok    该技术不存在!
          技术的jsonarray
   */
  Future<List<Jishu> > GetNoJishus() async{

    Map<String,String> map = Map();

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_NO,data: map);

    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<Jishu> jishus = new List();
        for(dynamic jsonstr in data['jishus']){
          //  var jsonmap = json.decode(data['jishu']);
          Jishu jishu = Jishu.fromJson(jsonstr);
          jishus.add(jishu);
        }
        return jishus;
      }

    }

    return null;

  }


  /*
    客服投票技术
    返回  message: ok    error
   */
  Future<String> voteJishu(Vote vote) async{

    Map<String,String> map = Map();
    map["vote"] = json.encode(vote.toJson());

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_VOTE_JISHU,data:map);
    String message = "error";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];

    }

    return message;

  }



  /*
      获得某技术  各个客服对他的投票详细情况

    服务器返回  message:  ok    该技术不存在!
          votedetail对象(若message为ok)


    该函数返回   list<votedetail>对象    若null对象 ，说明不存在,若一个空list即List()，说明请求服务器出错

   */
  Future<List<VoteDetail> > getVoteDetailListByJishuQQ(String jishuqq) async{

    Map<String,String> map = Map();
    map["jishuqq"] = jishuqq;

    var response = await HttpUtil.getInstance().get(HttpRoutePath.API_GET_JISHU_VoteDetail_QQ,data:map);
    String message = "该技术不存在!";
    if(response!=null&&response.statusCode==200){

      Map<String,dynamic> data = response.data;
      message = data['message'];
      if(message.compareTo("ok")==0){

        List<VoteDetail> votedetails = new List();
        for(dynamic jsonstr in data['jishus']){
          //  var jsonmap = json.decode(data['jishu']);
          VoteDetail voteDetail = VoteDetail.fromJson(jsonstr);
          votedetails.add(voteDetail);
        }
        return votedetails;
      }else{
        return null;
      }

    }

    return List<VoteDetail>();

  }


}