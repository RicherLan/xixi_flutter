import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoadingDialog {
  static bool _isShowing = false;
  static LoadingDialog loadingDialog;

  static LoadingDialog getInstance() {
    if (loadingDialog == null) {
      loadingDialog = LoadingDialog();
    }
    return loadingDialog;
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (!_isShowing) {
            _isShowing = true;
          }
          return getInstance();
        });
  }

  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

class LoadingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    //创建透明层
    return Material(
        type: MaterialType.transparency,
        child: WillPopScope(
          onWillPop: () async {
            MyLoadingDialog._isShowing = false;
            return true;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitCircle(
                color: Colors.white,
                size: 50,
              ),
              Text(
                "加载中",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
