
/*
  自定义分割线
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget{

  Color color = Colors.white;
  double height = 3;
  double paddingLeft = 0;
  double paddingRight = 0;

  DividerLine({this.height,this.color,this.paddingLeft,this.paddingRight});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: new EdgeInsets.all(0.0),
        child: new Divider(
          height: height,
            color: color,
        ),
        padding: EdgeInsets.only(left: paddingLeft, right: paddingLeft)
    );
  }

}