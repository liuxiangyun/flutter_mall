import 'dart:async';
import 'api_dio.dart';

///首页内容
Future homeContent() async {
  return await ApiDio().dio.post('wxmini/homePageContent',
      data: {'lon': '115.02932', 'lat': '35.76189'});
}

///火爆商品
Future hotProducts(int page) async {
  return await ApiDio()
      .dio
      .post('wxmini/homePageBelowConten', data: {'page': '$page'});
}

///分类
Future category() async {
  return await ApiDio().dio.post('wxmini/getCategory');
}
