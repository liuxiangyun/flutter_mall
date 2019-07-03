// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryProductListEntity _$CategoryProductListEntityFromJson(
    Map<String, dynamic> json) {
  return CategoryProductListEntity(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : CategoryProduct.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryProductListEntityToJson(
        CategoryProductListEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) {
  return CategoryProduct(
      json['image'] as String,
      (json['oriPrice'] as num)?.toDouble(),
      (json['presentPrice'] as num)?.toDouble(),
      json['goodsName'] as String,
      json['goodsId'] as String);
}

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'image': instance.image,
      'oriPrice': instance.oriPrice,
      'presentPrice': instance.presentPrice,
      'goodsName': instance.goodsName,
      'goodsId': instance.goodsId
    };
