
/*
  技术实体类
 */

class Jishu {


  String _qq;
  String _wx ;
  int _yes;                   //支持数量
  int _no ;                   //否定数量
  String _info ;                //其他信息
  String _label ;                //标签
  String _skill ;              //会的技术语言

  int _yesorno;             //某客服是否对该技术投过票    -1不靠谱    0没投     1靠谱

  Jishu.structByQQ(this._qq);
  Jishu.structByNULL();           //默认构造函数
  Jishu(this._qq, this._wx,this._yes,this._no, this._info, this._label, this._skill,this._yesorno);


  factory Jishu.fromJson(Map<String,dynamic> json){
    Jishu jishu = Jishu.structByNULL();
    jishu._qq = json['qq'];
    jishu. _wx = json['wx'];
    jishu. _yes = json['yes'];                   //支持数量
    jishu. _no = json['no'];                   //否定数量
    jishu. _info = json['info'];                //其他信息
    jishu. _label = json['label'];                //标签
    jishu. _skill = json['skill'];              //会的技术语言
    jishu. _yesorno = json['yesorno'];              //会的技术语言


    return jishu;
  }

  Map<String, dynamic> toJson() =>
      {
        'qq': _qq,
        'wx': _wx,
        'yes': _yes,
        'no': _no,
        'info': _info,
        'label': _label,
        'skill': _skill,
        'yesorno': _yesorno,
    };

  String get skill => _skill;

  set skill(String value) {
    _skill = value;
  }

  String get label => _label;

  set label(String value) {
    _label = value;
  }

  String get info => _info;

  set info(String value) {
    _info = value;
  }

  int get no => _no;

  set no(int value) {
    _no = value;
  }

  int get yes => _yes;

  set yes(int value) {
    _yes = value;
  }

  String get wx => _wx;

  set wx(String value) {
    _wx = value;
  }

  String get qq => _qq;

  set qq(String value) {
    _qq = value;
  }

  int get yesorno => _yesorno;

  set yesorno(int value) {
    _yesorno = value;
  }


}