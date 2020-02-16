

/*
  网络状态监听
 */

import 'package:connectivity/connectivity.dart';

class NetworkListener{

  static NetworkListener networkListener = null;

  static NetworkListener getINstance(){
    if(networkListener==null){
      networkListener = NetworkListener();
    }
    return networkListener;
  }


  Future<bool> isInternetAccess() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    }

    return false;
  }

}