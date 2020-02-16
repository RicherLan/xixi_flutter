
import 'package:flutter/material.dart';
import 'package:xixi/bean/Jishu.dart';

import 'VoteJishuDialogWidget.dart';




class VoteJishuDialog extends Dialog{

  Jishu jishu;
  VoteJishuDialog(this.jishu,{Key key}) : super(key: key);


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
            child: VoteJishuDialogWidget(jishu,_onSure,_onCancel),
          ),
        ),
      ),
    );
  }
}
