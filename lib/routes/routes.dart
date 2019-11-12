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
      Application.router
          .navigateTo(context, '$productDetailPage?id=$productId');
  }

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (context, params) {
      return Scaffold(
        appBar: AppBar(
          title: Text('页面错误'),
        ),
        body: Center(
          child: Text('无法找到此页面。。。'),
        ),
      );
    });

    router.define(productDetailPage, handler: productDetailHandler);
  }
}
