
import 'dart:math';

main(){

  String str = ".#123456789855511";

  if(MyTools.isInteger(str)){
    print("okkkkkkk");
  }
  print("11111111111111111111");
  return;
}

class MyTools {

  // 判断字符串是不是数字
  static bool isInteger(String str) {

    if(str==null||str.isEmpty){
      return false;
    }

    RegExp mobile = new RegExp(r'^[0-9]*$');
    return mobile.hasMatch(str);
  }

  /*
  //生成随机数字和字母,
  static String getRandomPassword(int length) {

    String val = "";
    Random random = new Random();
    // length为几位密码
    for (int i = 0; i < length; i++) {
      String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
      // 输出字母还是数字
      if ("char".equalsIgnoreCase(charOrNum)) {
        // 输出是大写字母还是小写字母
        int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
        val += (char) (random.nextInt(26) + temp);
      } else if ("num".equalsIgnoreCase(charOrNum)) {
        val += String.valueOf(random.nextInt(10));
      }
    }
    return val;
  }

*/
}
