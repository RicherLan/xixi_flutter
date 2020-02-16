
import 'package:flutter/material.dart';
import 'package:xixi/bean/Jishu.dart';
import 'package:xixi/bean/VoteDetail.dart';



class VoteDetailDialog extends Dialog{

  VoteDetail voteDetail;
  VoteDetailDialog(this.voteDetail);
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
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Text(
                    voteDetail.kefuname+(voteDetail.yesorno==1?"认为该技术靠谱":"认为该技术不靠谱"),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                   "该客服评价："+voteDetail.info,
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      RaisedButton(
                        child: Text("取消"),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ]),
          ),
        ),
      ),
    );
  }
}
