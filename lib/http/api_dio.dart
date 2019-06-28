import 'package:dio/dio.dart';
import 'dart:io';

const baseUrl = 'https://wxmini.baixingliangfan.cn/baixing/';

///debug模式，release包设置为false
const debug = true;

class ApiDio {
  // 工厂模式
  factory ApiDio() => _getInstance();

  static ApiDio get instance => _getInstance();

  static ApiDio _instance;

  final Dio dio = new Dio();

  ApiDio._internal() {
    //配置dio
    dio.options.baseUrl = baseUrl;
//    dio.options.headers = {'devicesType': 'android'};
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.options.sendTimeout = 30000;
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");

    //由于拦截器队列的执行顺序是FIFO，如果把log拦截器添加到了最前面，则后面拦截器对options的更改就不会被打印（但依然会生效），
    // 所以建议把log拦截添加到队尾。
    if (debug) {
      dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
    }
  }

  static ApiDio _getInstance() {
    if (_instance == null) {
      _instance = new ApiDio._internal();
    }
    return _instance;
  }
}
