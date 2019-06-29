import 'package:flutter/material.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:flutter_mall/widget/flutter_refresh.dart';
import 'package:flutter_mall/model/index_entity.dart';
import 'package:flutter_mall/model/hot_product_entity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future _future = indexContent();
  bool success = false;

  @override
  void initState() {
    super.initState();
    _getHotProducts(true);
  }

  void _refresh() {
    setState(() {
      _future = indexContent();
    });
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
              success = true;
              //请求成功
              var srcJson = json.decode(snapshot.data.toString());
              IndexEntity indexEntity = IndexEntity.fromJson(srcJson);

              if (indexEntity.code == '0') {
                return FlutterRefresh(
                    onRefresh: () async {
                      _refresh();
                    },
                    autoLoad: true,
                    loadMore: () async {
                      _getHotProducts(false);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SlidesImage(
                            slides: indexEntity.data.slides,
                          ),
                          NavigateCategory(
                            categorys: indexEntity.data.category,
                          ),
                          AdBanner(
                            advertesPicture: indexEntity.data.advertesPicture,
                          ),
                          MallInfo(
                            shopInfo: indexEntity.data.shopInfo,
                          ),
                          Promotion(
                            saoma: indexEntity.data.saoma,
                            integralMallPic: indexEntity.data.integralMallPic,
                            newUser: indexEntity.data.newUser,
                          ),
                          ProductRecommend(
                            recommends: indexEntity.data.recommend,
                          ),
                          ProductFloor(
                            floorPic: indexEntity.data.floor1Pic,
                            floor: indexEntity.data.floor1,
                          ),
                          ProductFloor(
                            floorPic: indexEntity.data.floor2Pic,
                            floor: indexEntity.data.floor2,
                          ),
                          ProductFloor(
                            floorPic: indexEntity.data.floor3Pic,
                            floor: indexEntity.data.floor3,
                          ),
                          _getHotProductWrap(),
                        ],
                      ),
                    ));
              } else {
                return Center(
                  child: Text(indexEntity.message),
                );
              }
            } else if (snapshot.hasError) {
              //请求失败
              return Center(
                child: InkWell(
                  child: Text(
                    '${snapshot.error.toString()}\n\n点击重试',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => _refresh(),
                ),
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
  List<HotProduct> _hotProducts = List<HotProduct>();

  void _getHotProducts(bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }

    hotProducts(_page).then((onValue) {
      var srcJson = json.decode(onValue.toString());
      HotProductEntity hotProductEntity = HotProductEntity.fromJson(srcJson);
      if (hotProductEntity.code == '0') {
        setState(() {
          if (isRefresh) {
            _hotProducts.clear();
          }
          _page++;
          _hotProducts.addAll(hotProductEntity.data);
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

  Widget _createHotProduct(HotProduct product) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(540),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: product.image,
            width: ScreenUtil().setWidth(400),
            height: ScreenUtil().setWidth(400),
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: primarySwatchColor),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '￥${product.mallPrice}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                ),
              ),
              Expanded(
                  child: Text(
                '￥${product.price}',
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
  final List<Slides> slides;

  SlidesImage({Key key, @required this.slides})
      : assert(slides != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: ScreenUtil().setWidth(500),
      child: Swiper.children(
        children: slides
            .map((slide) => FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: slide.image,
                  fit: BoxFit.fill,
                ))
            .toList(),
        autoplay: slides.length > 1,
        pagination: slides.length > 1 ? new SwiperPagination() : null,
      ),
    );
  }
}

///导航分类
class NavigateCategory extends StatelessWidget {
  final List<Category> categorys;

  NavigateCategory({Key key, @required this.categorys})
      : assert(categorys != null),
        super(key: key);

  Widget _createItem({@required Category category}) {
    return InkWell(
      child: Column(
        children: <Widget>[
          FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: category.image,
            width: ScreenUtil().setWidth(140),
            height: ScreenUtil().setWidth(140),
            fit: BoxFit.fill,
          ),
          Text(
            category.mallCategoryName,
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
          return _createItem(category: category);
        }).toList(),
      ),
    );
  }
}

///AD banner
class AdBanner extends StatelessWidget {
  final AdvertesPicture advertesPicture;

  AdBanner({Key key, @required this.advertesPicture})
      : assert(advertesPicture != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: advertesPicture.image,
        fit: BoxFit.fill,
      ),
    );
  }
}

///店铺信息
class MallInfo extends StatelessWidget {
  final ShopInfo shopInfo;

  MallInfo({
    Key key,
    @required this.shopInfo,
  })  : assert(shopInfo != null),
        super(key: key);

  void _launchPhone() async {
    String url = 'tel:$shopInfo.leaderPhone';
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
          image: shopInfo.leaderImage,
          fit: BoxFit.fill,
        ),
      ),
      onTap: () => _launchPhone(),
    );
  }
}

///促销
class Promotion extends StatelessWidget {
  final Saoma saoma;
  final IntegralMallPic integralMallPic;
  final NewUser newUser;

  Promotion(
      {Key key,
      @required this.saoma,
      @required this.integralMallPic,
      @required this.newUser})
      : assert(saoma != null),
        assert(integralMallPic != null),
        assert(newUser != null),
        super(key: key);

  Widget _createItem(String image) {
    return Container(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: image,
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
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _createItem(saoma.image),
          _createItem(integralMallPic.image),
          _createItem(newUser.image),
        ],
      ),
    );
  }
}

///商品推荐
class ProductRecommend extends StatelessWidget {
  final List<Recommend> recommends;

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
  Widget _createItem(Recommend recommend) {
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
            image: recommend.image,
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setWidth(300),
            fit: BoxFit.contain,
          ),
          Text(
            '￥${recommend.mallPrice}',
            style: TextStyle(fontSize: ScreenUtil().setSp(36)),
          ),
          Text(
            '￥${recommend.price}',
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
  final FloorPic floorPic;
  final List<Floor> floor;

  ProductFloor({Key key, @required this.floorPic, @required this.floor})
      : assert(floorPic != null),
        assert(floor != null),
        super(key: key);

  Widget _createFloorCategory() {
    return Container(
      color: primaryGrey,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      width: double.infinity,
      alignment: Alignment.center,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: floorPic.image,
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
              _createProduct(floor[0].image),
              Column(
                children: <Widget>[
                  _createProduct(floor[1].image),
                  _createProduct(floor[2].image),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              _createProduct(floor[3].image),
              _createProduct(floor[4].image),
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
