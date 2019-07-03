import 'package:json_annotation/json_annotation.dart'; 
  
part 'category_product_list_entity.g.dart';


@JsonSerializable()
  class CategoryProductListEntity extends Object {

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  List<CategoryProduct> data;

  CategoryProductListEntity(this.code,this.message,this.data,);

  factory CategoryProductListEntity.fromJson(Map<String, dynamic> srcJson) => _$CategoryProductListEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryProductListEntityToJson(this);

}

  
@JsonSerializable()
  class CategoryProduct extends Object {

  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'oriPrice')
  double oriPrice;

  @JsonKey(name: 'presentPrice')
  double presentPrice;

  @JsonKey(name: 'goodsName')
  String goodsName;

  @JsonKey(name: 'goodsId')
  String goodsId;

  CategoryProduct(this.image,this.oriPrice,this.presentPrice,this.goodsName,this.goodsId,);

  factory CategoryProduct.fromJson(Map<String, dynamic> srcJson) => _$CategoryProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);

}

  
