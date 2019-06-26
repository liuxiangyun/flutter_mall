import 'dart:async';
import 'api_dio.dart';

///获取首页内容
Future getIndexContent() async {
  return await ApiDio().dio.post('wxmini/homePageContent',
      data: {'lon': '115.02932', 'lat': '35.76189'});
}
