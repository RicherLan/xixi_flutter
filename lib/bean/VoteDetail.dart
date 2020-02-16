

/*
 * 客服对技术评价的详细信息
 */
class VoteDetail{
  String  _kefuname;
  String _kefuqq;
  String  _jishuqq;
  int _yesorno;                     //1代表支持   -1代表反对  
  String _info;


  VoteDetail.structByNULL();
  VoteDetail(this._kefuname, this._kefuqq, this._jishuqq, this._yesorno,this._info);



  factory VoteDetail.fromJson(Map<String,dynamic> json){
    VoteDetail voteDetail = VoteDetail.structByNULL();
    voteDetail._kefuname = json['kefuname'];
    voteDetail. _kefuqq = json['kefuqq'];
    voteDetail. _jishuqq = json['jishuqq'];
    voteDetail. _yesorno = json['yesorno'];

    voteDetail. _info = json['info'];



    return voteDetail;
  }

  Map<String, dynamic> toJson() =>
      {
        'kefuname': _kefuname,
        'kefuqq': _kefuqq,
        'jishuqq': _jishuqq,
        'yesorno': _yesorno,
        'info': _info,
      };

  String get kefuname => _kefuname;

  set kefuname(String value) {
    _kefuname = value;
  }

  String get kefuqq => _kefuqq;

  set kefuqq(String value) {
    _kefuqq = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }

  String get jishuqq => _jishuqq;

  set jishuqq(String value) {
    _jishuqq = value;
  }

  int get yesorno => _yesorno;

  set yesorno(int value) {
    _yesorno = value;
  }


}