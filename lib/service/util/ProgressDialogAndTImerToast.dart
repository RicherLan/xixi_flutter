

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xixi/service/util/MyLoadingDialog.dart';
import 'package:xixi/tools/MyUITools/ProgressDialog.dart';

class ProgressDialogAndTimerToast{

  Timer timer = null;
  int _timeSeconds = 6;
  String _toastString = "error";

  ProgressDialogAndTimerToast(this._timeSeconds,this._toastString);


  void begin(BuildContext context){

//    ProgressDialog.showProgressBeautiful(context);
    MyLoadingDialog.showLoadingDialog(context);
    timer = Timer(Duration(seconds: _timeSeconds),(){
//      ProgressDialog.dismiss(context);
      Fluttertoast.showToast(
          msg: _toastString,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      cancel(context);
    });
  }

  void cancel(BuildContext context){
      if(timer!=null){
        timer.cancel();
      }
      MyLoadingDialog.dismiss(context);
  }


}