import 'dart:async';
import 'api_dio.dart';
import 'package:flutter_mall/model/home_entity.dart';
import 'package:flutter_mall/model/hot_product_list_entity.dart';
import 'package:flutter_mall/model/category_entity.dart';
import 'package:flutter_mall/model/category_product_list_entity.dart';
import 'dart:convert';

///首页内容
Future<HomeEntity> homeContent() async {
  final response = await ApiDio().dio.post('wxmini/homePageContent',
      data: {'lon': '115.02932', 'lat': '35.76189'});
  final resJson = json.decode(response.toString());
  return HomeEntity.fromJson(resJson);
}

///火爆商品列表
Future<HotProductListEntity> hotProducts(int page) async {
  final response = await ApiDio()
      .dio
      .post('wxmini/homePageBelowConten', data: {'page': '$page'});
  final resJson = json.decode(response.toString());
  return HotProductListEntity.fromJson(resJson);
}

///分类
Future<CategoryEntity> category() async {
  final response = await ApiDio().dio.post('wxmini/getCategory');
  final resJson = json.decode(response.toString());
  return CategoryEntity.fromJson(resJson);
}

///分类商品列表
Future<CategoryProductListEntity> categoryProductList(
    String categoryId, String categorySubId, int page) async {
  final response = await ApiDio().dio.post('wxmini/getMallGoods', data: {
    'categoryId': categoryId,
    'categorySubId': categorySubId,
    'page': page
  });
  final resJson = json.decode(response.toString());
  return CategoryProductListEntity.fromJson(resJson);
}
