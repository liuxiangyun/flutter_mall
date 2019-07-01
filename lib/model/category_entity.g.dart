// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) {
  return CategoryEntity(
      json['code'] as String,
      json['message'] as String,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : FirstLevelCategory.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.firstLevelCategory
    };

FirstLevelCategory _$FirstLevelCategoryFromJson(Map<String, dynamic> json) {
  return FirstLevelCategory(
      json['mallCategoryId'] as String,
      json['mallCategoryName'] as String,
      (json['bxMallSubDto'] as List)
          ?.map((e) => e == null
              ? null
              : SecondLevelCategory.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['image'] as String);
}

Map<String, dynamic> _$FirstLevelCategoryToJson(FirstLevelCategory instance) =>
    <String, dynamic>{
      'mallCategoryId': instance.mallCategoryId,
      'mallCategoryName': instance.mallCategoryName,
      'bxMallSubDto': instance.secondLevelCategory,
      'image': instance.image
    };

SecondLevelCategory _$SecondLevelCategoryFromJson(Map<String, dynamic> json) {
  return SecondLevelCategory(
      json['mallSubId'] as String,
      json['mallCategoryId'] as String,
      json['mallSubName'] as String,
      json['comments'] as String);
}

Map<String, dynamic> _$SecondLevelCategoryToJson(
        SecondLevelCategory instance) =>
    <String, dynamic>{
      'mallSubId': instance.mallSubId,
      'mallCategoryId': instance.mallCategoryId,
      'mallSubName': instance.mallSubName,
      'comments': instance.comments
    };
