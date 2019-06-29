// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotProductEntity _$HotProductEntityFromJson(Map<String, dynamic> json) {
  return HotProductEntity(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : HotProduct.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HotProductEntityToJson(HotProductEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };

HotProduct _$HotProductFromJson(Map<String, dynamic> json) {
  return HotProduct(
      json['name'] as String,
      json['image'] as String,
      (json['mallPrice'] as num)?.toDouble(),
      json['goodsId'] as String,
      (json['price'] as num)?.toDouble());
}

Map<String, dynamic> _$HotProductToJson(HotProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'mallPrice': instance.mallPrice,
      'goodsId': instance.goodsId,
      'price': instance.price
    };
