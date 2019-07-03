import 'package:json_annotation/json_annotation.dart';

part 'hot_product_list_entity.g.dart';

@JsonSerializable()
class HotProductListEntity extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<HotProduct> data;

  HotProductListEntity(
    this.code,
    this.message,
    this.data,
  );

  factory HotProductListEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$HotProductListEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotProductListEntityToJson(this);
}

@JsonSerializable()
class HotProduct extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'mallPrice')
  double mallPrice;

  @JsonKey(name: 'goodsId')
  String goodsId;

  @JsonKey(name: 'price')
  double price;

  HotProduct(
    this.name,
    this.image,
    this.mallPrice,
    this.goodsId,
    this.price,
  );

  factory HotProduct.fromJson(Map<String, dynamic> srcJson) =>
      _$HotProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotProductToJson(this);
}
