import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<FirstLevelCategory> firstLevelCategory;

  CategoryEntity(
    this.code,
    this.message,
    this.firstLevelCategory,
  );

  factory CategoryEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}

@JsonSerializable()
class FirstLevelCategory extends Object {
  @JsonKey(name: 'mallCategoryId')
  String mallCategoryId;

  @JsonKey(name: 'mallCategoryName')
  String mallCategoryName;

  @JsonKey(name: 'bxMallSubDto')
  List<SecondLevelCategory> secondLevelCategory;

  @JsonKey(name: 'image')
  String image;

  FirstLevelCategory(
    this.mallCategoryId,
    this.mallCategoryName,
    this.secondLevelCategory,
    this.image,
  );

  factory FirstLevelCategory.fromJson(Map<String, dynamic> srcJson) =>
      _$FirstLevelCategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FirstLevelCategoryToJson(this);
}

@JsonSerializable()
class SecondLevelCategory extends Object {
  @JsonKey(name: 'mallSubId')
  String mallSubId;

  @JsonKey(name: 'mallCategoryId')
  String mallCategoryId;

  @JsonKey(name: 'mallSubName')
  String mallSubName;

  @JsonKey(name: 'comments')
  String comments;

  SecondLevelCategory(
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments,
  );

  factory SecondLevelCategory.fromJson(Map<String, dynamic> srcJson) =>
      _$SecondLevelCategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SecondLevelCategoryToJson(this);
}
