
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconAndBottomText extends StatelessWidget{

  double iconSize = 35;
  double fontsize = 5;

  IconData iconData = Icons.favorite;
  Color iconColor = Colors.red;
  Color selectedColor = Colors.red;
  Icon icon;
  String text;

//  Color notselectedColor = Color(0xe87d);


  final VoidCallback click;

  IconAndBottomText({this.iconData,this.iconSize,this.text,this.fontsize,this.click,this.iconColor}){
    icon = Icon(iconData,size:iconSize,color: iconColor,);
  }

  void setSelected(){
    icon = Icon(iconData,size:iconSize,color:selectedColor ,);

  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      width:iconSize+fontsize+10,
      height: iconSize+fontsize+50,
      child:   Column(
        children: <Widget>[
          icon,
          Text(text,style: TextStyle(fontSize: fontsize),maxLines: 3,),
        ],
      ),
    );


  }



}
