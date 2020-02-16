
/*
  投票实体类
 */
class Vote {

  String _kefuname = "";                   //客服名
  String _jishuqq = "";                  //技术qq
  int _yesorno = 1;                     //1代表支持   -1代表反对
  String _info = "";                      // 客服投票时给的理由

  Vote.structByNull();
  Vote(this._kefuname, this._jishuqq, this._yesorno,this._info);

  factory Vote.fromJson(Map<String,dynamic> json){
    Vote vote = Vote.structByNull();
    vote.kefuname = json['kefuname'];
    vote.jishuqq = json['jishuqq'];
    vote.yesorno = json['yesorno'];
    vote.info = json['info'];

    return vote;
  }


  Map<String, dynamic> toJson() =>
      {
        'kefuname': _kefuname,
        'jishuqq': _jishuqq,
        'yesorno': _yesorno,
        'info': _info,
      };

  String get info => _info;

  set info(String value) {
    _info = value;
  }


  int get yesorno => _yesorno;

  set yesorno(int value) {
    _yesorno = value;
  }

  String get jishuqq => _jishuqq;

  set jishuqq(String value) {
    _jishuqq = value;
  }

  String get kefuname => _kefuname;

  set kefuname(String value) {
    _kefuname = value;
  }


}
