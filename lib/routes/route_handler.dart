import 'package:fluro/fluro.dart';
import 'package:flutter_mall/pages/product_detail_page.dart';

///商品详情页
Handler productDetailHandler = Handler(handlerFunc: (context, params) {
  String goodsId = params['id'].first;
  return ProductDetailPage(goodsId);
});

