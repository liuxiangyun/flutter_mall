import 'package:json_annotation/json_annotation.dart';

part 'hot_product_entity.g.dart';

@JsonSerializable()
class HotProductEntity extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<HotProduct> data;

  HotProductEntity(
    this.code,
    this.message,
    this.data,
  );

  factory HotProductEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$HotProductEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotProductEntityToJson(this);
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
