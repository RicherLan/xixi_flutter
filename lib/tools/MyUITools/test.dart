

import 'package:xixi/bean/Jishu.dart';

void main(){

  Jishu jishu = Jishu(
      "1348247",
      "lwh134827",
      10,
      3,
      "顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶顶",
      "商单",
      "java 前端 sql",
  0);
  print(jishu.qq);
  change(jishu);
  print(jishu.qq);

}

void change(Jishu jishu){

  jishu.qq = "123456";
  print(jishu.qq);

}