

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:xixi/service/Service.dart';
import 'package:xixi/service/userhttpservice/UserService.dart';

import 'HttpRoutePath.dart';

void main() async {




//HttpUtil().get(url3,data:{"username":"123","password":"asda"});         //第一种方式
//    Dio().get(url3,queryParameters:{"username":"1号客服","password":"12345"});
  Map<String,String> map = Map();                         //第2种方式
  map["username"] = "1号客服";
  map["password"] = "12345";
  FormData formData = FormData.fromMap(map);

  var response = await HttpUtil().get(HttpRoutePath.API_LOGIN,data:map);

  if(response.statusCode == 200){

    Map<String,dynamic> map = json.decode(response.data);
    print(map['security']);
    print('message');
  }

}


class HttpUtil {


  static String httpURL = "http://ip:port";
  static int awaitServerTime = 18;            //  每一个请求    如果该时间后  接收不到服务器回执  则报警
  static String securityStr;         //登陆后    服务器返回这个   以后请求每次都要带着这个   已验证


  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

  CancelToken cancelToken = new CancelToken();

  static HttpUtil getInstance() {
    if (null == instance) instance = new HttpUtil();
    return instance;
  }



  /*
   * config it and create
   */
  HttpUtil() {
    //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    options = new BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: httpURL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,
      //响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      //Http请求头.
      headers: {
        //do something
        "version": "1.0.0"
      },
      //请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
//      contentType: ContentType.json,
      //表示期望以那种格式(方式)接受响应数据。接受4种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
     // responseType: ResponseType.json,
    );

    dio = new Dio(options);

    /*
    //Cookie管理
    dio.interceptors.add(CookieManager(CookieJar()));

    //添加拦截器
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求之前");
      // Do something before request is sent
      return options; //continue
    }, onResponse: (Response response) {
      print("响应之前");
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) {
      print("错误之前");
      // Do something with response error
      return e; //continue
    }));

     */
  }

  /*
   * get请求
   */
  get(url, {data, options, cancelToken}) async {
    Response response;
    data['securityStr'] = securityStr;
    data['kefuname'] = Service.loginUsername;
    try {
      response = await dio.get(url, queryParameters: data, options: options, cancelToken: cancelToken);

      if(response!=null&&response.statusCode==200){

        Map<String,dynamic> data = response.data;
        String message = data['message'];
        if(message!=null&&message.compareTo("Illegal user")==0) {
          UserService.getInstance().login(Service.loginUsername,Service.loginPassword);
        }
      }

      print('get success---------${response.statusCode}');
      print('get success---------${response.data}');

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      print('get error---------$e');
      formatError(e);
    }
    return response;
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    data['securityStr'] = securityStr;
    data['kefuname'] = Service.loginUsername;

    Response response;
    try {
      print(httpURL+url);
      print(data);
      response = await dio.post(url, data: data, options: options, cancelToken: cancelToken);
     
      if(response!=null&&response.statusCode==200){

        Map<String,dynamic> data = response.data;
        String message = data['message'];
        if(message!=null&&message.compareTo("Illegal user")==0) {

          print("Illegal user   "+"try  login");

          UserService.getInstance().login(Service.loginUsername,Service.loginPassword);
        }
      }

      print('post success---------${response.statusCode}');
      print('post success---------${response.data}');
    } on DioError catch (e) {
      print('post error---------$e');
      formatError(e);
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,onReceiveProgress: (int count, int total){
        //进度
        print("$count $total");
      });
      print('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      print('downloadFile error---------$e');
      formatError(e);
    }
    return response;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
