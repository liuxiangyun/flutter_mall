// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeEntity _$HomeEntityFromJson(Map<String, dynamic> json) {
  return HomeEntity(
      json['code'] as String,
      json['message'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$HomeEntityToJson(HomeEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      (json['slides'] as List)
          ?.map((e) =>
              e == null ? null : Slides.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['shopInfo'] == null
          ? null
          : ShopInfo.fromJson(json['shopInfo'] as Map<String, dynamic>),
      json['integralMallPic'] == null
          ? null
          : IntegralMallPic.fromJson(
              json['integralMallPic'] as Map<String, dynamic>),
      json['toShareCode'] == null
          ? null
          : ToShareCode.fromJson(json['toShareCode'] as Map<String, dynamic>),
      (json['recommend'] as List)
          ?.map((e) =>
              e == null ? null : Recommend.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['advertesPicture'] == null
          ? null
          : AdvertesPicture.fromJson(
              json['advertesPicture'] as Map<String, dynamic>),
      (json['floor1'] as List)
          ?.map((e) =>
              e == null ? null : Floor.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['floor2'] as List)
          ?.map((e) =>
              e == null ? null : Floor.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['floor3'] as List)
          ?.map((e) =>
              e == null ? null : Floor.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['saoma'] == null
          ? null
          : Saoma.fromJson(json['saoma'] as Map<String, dynamic>),
      json['newUser'] == null
          ? null
          : NewUser.fromJson(json['newUser'] as Map<String, dynamic>),
      json['floor1Pic'] == null
          ? null
          : FloorPic.fromJson(json['floor1Pic'] as Map<String, dynamic>),
      json['floor2Pic'] == null
          ? null
          : FloorPic.fromJson(json['floor2Pic'] as Map<String, dynamic>),
      json['floorName'] == null
          ? null
          : FloorName.fromJson(json['floorName'] as Map<String, dynamic>),
      (json['category'] as List)
          ?.map((e) =>
              e == null ? null : Category.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['floor3Pic'] == null
          ? null
          : FloorPic.fromJson(json['floor3Pic'] as Map<String, dynamic>),
      json['reservationGoods'] as List);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'slides': instance.slides,
      'shopInfo': instance.shopInfo,
      'integralMallPic': instance.integralMallPic,
      'toShareCode': instance.toShareCode,
      'recommend': instance.recommend,
      'advertesPicture': instance.advertesPicture,
      'floor1': instance.floor1,
      'floor2': instance.floor2,
      'floor3': instance.floor3,
      'saoma': instance.saoma,
      'newUser': instance.newUser,
      'floor1Pic': instance.floor1Pic,
      'floor2Pic': instance.floor2Pic,
      'floor3Pic': instance.floor3Pic,
      'floorName': instance.floorName,
      'category': instance.category,
      'reservationGoods': instance.reservationGoods
    };

Slides _$SlidesFromJson(Map<String, dynamic> json) {
  return Slides(json['image'] as String, json['goodsId'] as String);
}

Map<String, dynamic> _$SlidesToJson(Slides instance) =>
    <String, dynamic>{'image': instance.image, 'goodsId': instance.goodsId};

ShopInfo _$ShopInfoFromJson(Map<String, dynamic> json) {
  return ShopInfo(json['leaderImage'] as String, json['leaderPhone'] as String);
}

Map<String, dynamic> _$ShopInfoToJson(ShopInfo instance) => <String, dynamic>{
      'leaderImage': instance.leaderImage,
      'leaderPhone': instance.leaderPhone
    };

IntegralMallPic _$IntegralMallPicFromJson(Map<String, dynamic> json) {
  return IntegralMallPic(
      json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$IntegralMallPicToJson(IntegralMallPic instance) =>
    <String, dynamic>{
      'PICTURE_ADDRESS': instance.image,
      'TO_PLACE': instance.tOPLACE
    };

ToShareCode _$ToShareCodeFromJson(Map<String, dynamic> json) {
  return ToShareCode(
      json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$ToShareCodeToJson(ToShareCode instance) =>
    <String, dynamic>{
      'PICTURE_ADDRESS': instance.pICTUREADDRESS,
      'TO_PLACE': instance.tOPLACE
    };

Recommend _$RecommendFromJson(Map<String, dynamic> json) {
  return Recommend(
      json['image'] as String,
      (json['mallPrice'] as num)?.toDouble(),
      json['goodsName'] as String,
      json['goodsId'] as String,
      (json['price'] as num)?.toDouble());
}

Map<String, dynamic> _$RecommendToJson(Recommend instance) => <String, dynamic>{
      'image': instance.image,
      'mallPrice': instance.mallPrice,
      'goodsName': instance.goodsName,
      'goodsId': instance.goodsId,
      'price': instance.price
    };

AdvertesPicture _$AdvertesPictureFromJson(Map<String, dynamic> json) {
  return AdvertesPicture(
      json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$AdvertesPictureToJson(AdvertesPicture instance) =>
    <String, dynamic>{
      'PICTURE_ADDRESS': instance.image,
      'TO_PLACE': instance.tOPLACE
    };

Floor _$FloorFromJson(Map<String, dynamic> json) {
  return Floor(json['image'] as String, json['goodsId'] as String);
}

Map<String, dynamic> _$FloorToJson(Floor instance) =>
    <String, dynamic>{'image': instance.image, 'goodsId': instance.goodsId};

Saoma _$SaomaFromJson(Map<String, dynamic> json) {
  return Saoma(json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$SaomaToJson(Saoma instance) => <String, dynamic>{
      'PICTURE_ADDRESS': instance.image,
      'TO_PLACE': instance.tOPLACE
    };

NewUser _$NewUserFromJson(Map<String, dynamic> json) {
  return NewUser(json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'PICTURE_ADDRESS': instance.image,
      'TO_PLACE': instance.tOPLACE
    };

FloorPic _$FloorPicFromJson(Map<String, dynamic> json) {
  return FloorPic(
      json['PICTURE_ADDRESS'] as String, json['TO_PLACE'] as String);
}

Map<String, dynamic> _$FloorPicToJson(FloorPic instance) => <String, dynamic>{
      'PICTURE_ADDRESS': instance.image,
      'TO_PLACE': instance.tOPLACE
    };

FloorName _$FloorNameFromJson(Map<String, dynamic> json) {
  return FloorName(json['floor1'] as String, json['floor2'] as String,
      json['floor3'] as String);
}

Map<String, dynamic> _$FloorNameToJson(FloorName instance) => <String, dynamic>{
      'floor1': instance.floor1,
      'floor2': instance.floor2,
      'floor3': instance.floor3
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
      json['mallCategoryId'] as String,
      json['mallCategoryName'] as String,
      (json['bxMallSubDto'] as List)
          ?.map((e) => e == null
              ? null
              : BxMallSubDto.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['image'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'mallCategoryId': instance.mallCategoryId,
      'mallCategoryName': instance.mallCategoryName,
      'bxMallSubDto': instance.bxMallSubDto,
      'image': instance.image
    };

BxMallSubDto _$BxMallSubDtoFromJson(Map<String, dynamic> json) {
  return BxMallSubDto(
      json['mallSubId'] as String,
      json['mallCategoryId'] as String,
      json['mallSubName'] as String,
      json['comments'] as String);
}

Map<String, dynamic> _$BxMallSubDtoToJson(BxMallSubDto instance) =>
    <String, dynamic>{
      'mallSubId': instance.mallSubId,
      'mallCategoryId': instance.mallCategoryId,
      'mallSubName': instance.mallSubName,
      'comments': instance.comments
    };
