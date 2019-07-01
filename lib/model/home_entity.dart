import 'package:json_annotation/json_annotation.dart';

part 'home_entity.g.dart';

@JsonSerializable()
class HomeEntity extends Object {
  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'data')
  Data data;

  HomeEntity(
    this.code,
    this.message,
    this.data,
  );

  factory HomeEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$HomeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeEntityToJson(this);
}

@JsonSerializable()
class Data extends Object {
  @JsonKey(name: 'slides')
  List<Slides> slides;

  @JsonKey(name: 'shopInfo')
  ShopInfo shopInfo;

  @JsonKey(name: 'integralMallPic')
  IntegralMallPic integralMallPic;

  @JsonKey(name: 'toShareCode')
  ToShareCode toShareCode;

  @JsonKey(name: 'recommend')
  List<Recommend> recommend;

  @JsonKey(name: 'advertesPicture')
  AdvertesPicture advertesPicture;

  @JsonKey(name: 'floor1')
  List<Floor> floor1;

  @JsonKey(name: 'floor2')
  List<Floor> floor2;

  @JsonKey(name: 'floor3')
  List<Floor> floor3;

  @JsonKey(name: 'saoma')
  Saoma saoma;

  @JsonKey(name: 'newUser')
  NewUser newUser;

  @JsonKey(name: 'floor1Pic')
  FloorPic floor1Pic;

  @JsonKey(name: 'floor2Pic')
  FloorPic floor2Pic;

  @JsonKey(name: 'floor3Pic')
  FloorPic floor3Pic;

  @JsonKey(name: 'floorName')
  FloorName floorName;

  @JsonKey(name: 'category')
  List<Category> category;

  @JsonKey(name: 'reservationGoods')
  List<dynamic> reservationGoods;

  Data(
    this.slides,
    this.shopInfo,
    this.integralMallPic,
    this.toShareCode,
    this.recommend,
    this.advertesPicture,
    this.floor1,
    this.floor2,
    this.floor3,
    this.saoma,
    this.newUser,
    this.floor1Pic,
    this.floor2Pic,
    this.floorName,
    this.category,
    this.floor3Pic,
    this.reservationGoods,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Slides extends Object {
  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'goodsId')
  String goodsId;

  Slides(
    this.image,
    this.goodsId,
  );

  factory Slides.fromJson(Map<String, dynamic> srcJson) =>
      _$SlidesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SlidesToJson(this);
}

@JsonSerializable()
class ShopInfo extends Object {
  @JsonKey(name: 'leaderImage')
  String leaderImage;

  @JsonKey(name: 'leaderPhone')
  String leaderPhone;

  ShopInfo(
    this.leaderImage,
    this.leaderPhone,
  );

  factory ShopInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ShopInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShopInfoToJson(this);
}

@JsonSerializable()
class IntegralMallPic extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String image;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  IntegralMallPic(
    this.image,
    this.tOPLACE,
  );

  factory IntegralMallPic.fromJson(Map<String, dynamic> srcJson) =>
      _$IntegralMallPicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IntegralMallPicToJson(this);
}

@JsonSerializable()
class ToShareCode extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String pICTUREADDRESS;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  ToShareCode(
    this.pICTUREADDRESS,
    this.tOPLACE,
  );

  factory ToShareCode.fromJson(Map<String, dynamic> srcJson) =>
      _$ToShareCodeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ToShareCodeToJson(this);
}

@JsonSerializable()
class Recommend extends Object {
  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'mallPrice')
  double mallPrice;

  @JsonKey(name: 'goodsName')
  String goodsName;

  @JsonKey(name: 'goodsId')
  String goodsId;

  @JsonKey(name: 'price')
  double price;

  Recommend(
    this.image,
    this.mallPrice,
    this.goodsName,
    this.goodsId,
    this.price,
  );

  factory Recommend.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendToJson(this);
}

@JsonSerializable()
class AdvertesPicture extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String image;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  AdvertesPicture(
    this.image,
    this.tOPLACE,
  );

  factory AdvertesPicture.fromJson(Map<String, dynamic> srcJson) =>
      _$AdvertesPictureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AdvertesPictureToJson(this);
}

@JsonSerializable()
class Floor extends Object {
  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'goodsId')
  String goodsId;

  Floor(
    this.image,
    this.goodsId,
  );

  factory Floor.fromJson(Map<String, dynamic> srcJson) =>
      _$FloorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FloorToJson(this);
}

@JsonSerializable()
class Saoma extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String image;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  Saoma(
    this.image,
    this.tOPLACE,
  );

  factory Saoma.fromJson(Map<String, dynamic> srcJson) =>
      _$SaomaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SaomaToJson(this);
}

@JsonSerializable()
class NewUser extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String image;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  NewUser(
    this.image,
    this.tOPLACE,
  );

  factory NewUser.fromJson(Map<String, dynamic> srcJson) =>
      _$NewUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewUserToJson(this);
}

@JsonSerializable()
class FloorPic extends Object {
  @JsonKey(name: 'PICTURE_ADDRESS')
  String image;

  @JsonKey(name: 'TO_PLACE')
  String tOPLACE;

  FloorPic(
    this.image,
    this.tOPLACE,
  );

  factory FloorPic.fromJson(Map<String, dynamic> srcJson) =>
      _$FloorPicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FloorPicToJson(this);
}

@JsonSerializable()
class FloorName extends Object {
  @JsonKey(name: 'floor1')
  String floor1;

  @JsonKey(name: 'floor2')
  String floor2;

  @JsonKey(name: 'floor3')
  String floor3;

  FloorName(
    this.floor1,
    this.floor2,
    this.floor3,
  );

  factory FloorName.fromJson(Map<String, dynamic> srcJson) =>
      _$FloorNameFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FloorNameToJson(this);
}

@JsonSerializable()
class Category extends Object {
  @JsonKey(name: 'mallCategoryId')
  String mallCategoryId;

  @JsonKey(name: 'mallCategoryName')
  String mallCategoryName;

  @JsonKey(name: 'bxMallSubDto')
  List<BxMallSubDto> bxMallSubDto;

  @JsonKey(name: 'image')
  String image;

  Category(
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.image,
  );

  factory Category.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class BxMallSubDto extends Object {
  @JsonKey(name: 'mallSubId')
  String mallSubId;

  @JsonKey(name: 'mallCategoryId')
  String mallCategoryId;

  @JsonKey(name: 'mallSubName')
  String mallSubName;

  @JsonKey(name: 'comments')
  String comments;

  BxMallSubDto(
    this.mallSubId,
    this.mallCategoryId,
    this.mallSubName,
    this.comments,
  );

  factory BxMallSubDto.fromJson(Map<String, dynamic> srcJson) =>
      _$BxMallSubDtoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BxMallSubDtoToJson(this);
}
