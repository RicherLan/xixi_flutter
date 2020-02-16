
import 'package:flutter/material.dart';
import 'package:xixi/bean/Jishu.dart';

import 'JishuInfouChangeWidget.dart';


class JishuInfouChangeDialog extends Dialog{

  Jishu jishu;
  int index;           //1代表修改的是微信，2：技术语言栈    3：标签     4：其他
  JishuInfouChangeDialog(this.jishu,this.index,{Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    void _onCancel() {
      Navigator.pop(context);
    }

    void _onSure() {

    }

    return new Material( //创建透明层
        type: MaterialType.transparency, //透明类型
        child:Center( //保证控件居中效果
          child: IntrinsicHeight(
              child: Container(
                  decoration: ShapeDecoration(
                  color: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)
                      ),
                      ),
                  ),
                  child: JishuInfouChangeWidget(jishu,index,_onSure,_onCancel),
              ),
          ),
        ),
    );
  }
}
