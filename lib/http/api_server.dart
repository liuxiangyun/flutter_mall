import 'dart:async';
import 'api_dio.dart';

///获取首页内容
Future indexContent() async {
  return await ApiDio().dio.post('wxmini/homePageContent',
      data: {'lon': '115.02932', 'lat': '35.76189'});
}

///获取火爆商品
Future hotProducts(int page) async {
  return await ApiDio().dio.post('wxmini/homePageBelowConten',
      data: {'page': '$page'});
}
