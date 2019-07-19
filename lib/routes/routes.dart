import 'package:fluro/fluro.dart';
import 'package:flutter_mall/routes/route_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_mall/routes/application.dart';
import 'package:flutter/material.dart';

class Routes {
  ///根
  static final String root = '/';

  ///商品详情页
  static final String productDetailPage = '/productDetailPage';

  static navigateToProductDetail(BuildContext context, String productId) {
    Application.router.navigateTo(context, '$productDetailPage?id=$productId');
  }

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      Fluttertoast.showToast(msg: '没找到路由。。。');
      return Scaffold(
        appBar: AppBar(
          title: Text('路由错误'),
        ),
        body: Center(
          child: Text('没找到路由。。。'),
        ),
      );
    });

    router.define(productDetailPage, handler: productDetailHandler);
  }
}
