
/*
  客服实体类
 */

class KeFu {


  String _username;
  String _password;
  String _qq;

  KeFu.structByName(this._username);
  KeFu.strtctByNULL();
  KeFu(this._username, this._password,this._qq) ;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get qq => _qq;

  set qq(String value) {
    _qq = value;
  }


}