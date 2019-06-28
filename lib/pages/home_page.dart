import 'package:flutter/material.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:flutter_mall/widget/flutter_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future _future = indexContent();

  @override
  void initState() {
    super.initState();
    _getHotProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //请求成功
              var data = json.decode(snapshot.data.toString());
              if (data['code'] == '0') {
                List<Map> slides = (data['data']['slides'] as List).cast();
                List<Map> navCategorys =
                    (data['data']['category'] as List).cast();
                List<Map> promotions = List<Map>();
                promotions.add(data['data']['saoma']);
                promotions.add(data['data']['integralMallPic']);
                promotions.add(data['data']['newUser']);
                List<Map> recommends = List<Map>();
                recommends.addAll((data['data']['recommend'] as List).cast());
                recommends.addAll((data['data']['recommend'] as List).cast());
                recommends.addAll((data['data']['recommend'] as List).cast());
                String floor1Pic = data['data']['floor1Pic']['PICTURE_ADDRESS'];
                String floor2Pic = data['data']['floor2Pic']['PICTURE_ADDRESS'];
                String floor3Pic = data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 = (data['data']['floor1'] as List).cast();
                List<Map> floor2 = (data['data']['floor2'] as List).cast();
                List<Map> floor3 = (data['data']['floor3'] as List).cast();

                return FlutterRefresh(
                    onRefresh: () async {
                      setState(() {
                        _future = indexContent();
                      });
                      _getHotProducts(true);
                    },
                    autoLoad:true,
                    loadMore: () async {
                      _getHotProducts(false);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SlidesImage(
                              images: slides
                                  .map((slide) => slide['image'])
                                  .toList()
                                  .cast()),
                          NavigateCategory(
                            categorys: navCategorys,
                          ),
                          AdBanner(
                            adPicUrl: data['data']['advertesPicture']
                                ['PICTURE_ADDRESS'],
                          ),
                          ShopInfo(
                            leaderImage: data['data']['shopInfo']
                                ['leaderImage'],
                            leaderPhone: data['data']['shopInfo']
                                ['leaderPhone'],
                          ),
                          Promotion(
                            promotions: promotions,
                          ),
                          ProductRecommend(
                            recommends: recommends,
                          ),
                          ProductFloor(
                            floorCategory: floor1Pic,
                            floorProducts: floor1,
                          ),
                          ProductFloor(
                            floorCategory: floor2Pic,
                            floorProducts: floor2,
                          ),
                          ProductFloor(
                            floorCategory: floor3Pic,
                            floorProducts: floor3,
                          ),
                          _getHotProductWrap(),
                        ],
                      ),
                    ));
              } else {
                return Center(
                  child: Text(data['message']),
                );
              }
            } else if (snapshot.hasError) {
              //请求失败
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              //请求中
              return Center(
                child: Text('加载中...'),
              );
            }
          },
          //接口获取首页信息
          future: _future,
        ));
  }

  @override
  bool get wantKeepAlive => true;

  ///火爆商品
  int _page = 1;
  List<Map> _hotProducts = List<Map>();

  void _getHotProducts(bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }

    hotProducts(_page).then((onValue) {
      var data = json.decode(onValue.toString());
      if (data['code'] == '0') {
        setState(() {
          if (isRefresh) {
            _hotProducts.clear();
          }
          _page++;
          _hotProducts.addAll((data['data'] as List).cast());
        });
      }
    });
  }

  Widget _getHotProductWrap() {
    return Column(
      children: <Widget>[
        Container(
          color: primaryGrey,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            '火爆专区',
            style: TextStyle(
                color: primarySwatchColor, fontSize: ScreenUtil().setSp(40)),
          ),
        ),
        Wrap(
          children: _hotProducts
              .map((product) => _createHotProduct(product))
              .toList(),
        ),
      ],
    );
  }

  Widget _createHotProduct(item) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(540),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item['image'],
            width: ScreenUtil().setWidth(400),
            height: ScreenUtil().setWidth(400),
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              item['name'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: primarySwatchColor),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '￥${item['mallPrice']}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                ),
              ),
              Expanded(
                  child: Text(
                '￥${item['price']}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey[400],
                    decoration: TextDecoration.lineThrough,
                    fontSize: ScreenUtil().setSp(34)),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

///轮播图
class SlidesImage extends StatelessWidget {
  final List<String> images;

  SlidesImage({Key key, @required this.images})
      : assert(images != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: ScreenUtil().setWidth(500),
      child: Swiper.children(
        children: images
            .map((url) => FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: url,
                  fit: BoxFit.fill,
                ))
            .toList(),
        autoplay: images.length > 1,
        pagination: images.length > 1 ? new SwiperPagination() : null,
      ),
    );
  }
}

///导航分类
class NavigateCategory extends StatelessWidget {
  final List categorys;

  NavigateCategory({Key key, @required this.categorys})
      : assert(categorys != null),
        super(key: key);

  Widget _createItem(
      {@required String categoryImage, @required String categoryName}) {
    assert(categoryImage != null && categoryImage.isNotEmpty);
    assert(categoryName != null && categoryName.isNotEmpty);

    return InkWell(
      child: Column(
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: categoryImage,
            width: ScreenUtil().setWidth(140),
            height: ScreenUtil().setWidth(140),
            fit: BoxFit.fill,
          ),
          Text(
            categoryName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: ScreenUtil().setSp(36)),
          ),
        ],
      ),
      onTap: () => print('navigate category onTap'),
    );
  }

  @override
  Widget build(BuildContext context) {
    //只显示10个多余的remove
    if (categorys.length > 10) {
      categorys.removeRange(10, categorys.length);
    }

    return Container(
      color: Colors.white,
      width: double.infinity,
      height: ScreenUtil().setWidth(484),
      padding: EdgeInsets.only(top: 12, bottom: 5),
      child: GridView.count(
        crossAxisCount: 5,
        physics: NeverScrollableScrollPhysics(),
        children: categorys.map((category) {
          return _createItem(
              categoryImage: category['image'],
              categoryName: category['mallCategoryName']);
        }).toList(),
      ),
    );
  }
}

///AD banner
class AdBanner extends StatelessWidget {
  final String adPicUrl;

  AdBanner({Key key, @required this.adPicUrl})
      : assert(adPicUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: adPicUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}

///店铺信息
class ShopInfo extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  ShopInfo({Key key, @required this.leaderImage, @required this.leaderPhone})
      : assert(leaderImage != null),
        assert(leaderPhone != null),
        super(key: key);

  void _launchPhone() async {
    String url = 'tel:$leaderPhone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        width: double.infinity,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: leaderImage,
          fit: BoxFit.fill,
        ),
      ),
      onTap: () => _launchPhone(),
    );
  }
}

///促销
class Promotion extends StatelessWidget {
  final List promotions;

  Promotion({Key key, @required this.promotions})
      : assert(promotions != null),
        super(key: key);

  Widget _createItem(var item) {
    return Container(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item['PICTURE_ADDRESS'],
        width: ScreenUtil().setWidth(360),
        height: ScreenUtil().setWidth(424),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topLeft,
      height: ScreenUtil().setWidth(450),
      child: ListView.builder(
          itemBuilder: (context, index) => _createItem(promotions[index]),
          itemCount: promotions.length,
          scrollDirection: Axis.horizontal),
    );
  }
}

///商品推荐
class ProductRecommend extends StatelessWidget {
  final List recommends;

  ProductRecommend({Key key, @required this.recommends})
      : assert(recommends != null),
        super(key: key);

  //标题
  Widget _title(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 10, color: primaryGrey),
          bottom: BorderSide(width: 0.5, color: primaryGrey),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: ScreenUtil().setSp(40)),
      ),
    );
  }

  //商品
  Widget _createItem(var item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(width: 0.5, color: primaryGrey)),
      ),
      child: Column(
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item['image'],
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setWidth(300),
            fit: BoxFit.contain,
          ),
          Text(
            '￥${item['mallPrice']}',
            style: TextStyle(fontSize: ScreenUtil().setSp(36)),
          ),
          Text(
            '￥${item['price']}',
            style: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.lineThrough,
                fontSize: ScreenUtil().setSp(26)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _title(context),
        Container(
          color: Colors.white,
          alignment: Alignment.topLeft,
          height: ScreenUtil().setWidth(450),
          child: ListView.builder(
              itemBuilder: (context, index) => _createItem(recommends[index]),
              itemCount: recommends.length,
              scrollDirection: Axis.horizontal),
        ),
      ],
    );
  }
}

///楼层
class ProductFloor extends StatelessWidget {
  final String floorCategory;
  final List floorProducts;

  ProductFloor(
      {Key key, @required this.floorCategory, @required this.floorProducts})
      : assert(floorCategory != null),
        assert(floorProducts != null),
        super(key: key);

  Widget _createFloorCategory() {
    return Container(
      color: primaryGrey,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: double.infinity,
      alignment: Alignment.center,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: floorCategory,
        width: ScreenUtil().setWidth(1000),
      ),
    );
  }

  Widget _createProduct(String picUrl) {
    return Container(
      width: ScreenUtil().setWidth(540),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: picUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crateFloorProducts() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              _createProduct(floorProducts[0]['image']),
              Column(
                children: <Widget>[
                  _createProduct(floorProducts[1]['image']),
                  _createProduct(floorProducts[2]['image']),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _createProduct(floorProducts[3]['image']),
              _createProduct(floorProducts[4]['image']),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _createFloorCategory(),
          _crateFloorProducts(),
        ],
      ),
    );
  }
}
