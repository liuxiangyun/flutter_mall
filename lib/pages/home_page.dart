import 'package:flutter/material.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:flutter_mall/model/home_entity.dart';
import 'package:flutter_mall/model/hot_product_list_entity.dart';
import 'package:flutter_mall/res/font.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future<HomeEntity> _homeFuture = homeContent();
  bool success = false;

  @override
  void initState() {
    super.initState();
    _getHotProducts(true);
  }

  void _refresh() {
    setState(() {
      _homeFuture = homeContent();
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
            HomeEntity homeEntity = snapshot.data;

            if (homeEntity.code == '0') {
              List<Recommend> recommends = [];
              recommends
                ..addAll(homeEntity.data.recommend)
                ..addAll(homeEntity.data.recommend)
                ..addAll(homeEntity.data.recommend);
              return EasyRefresh(
                refreshHeader: MaterialHeader(
                  key: new GlobalKey<RefreshHeaderState>(),
                ),
                refreshFooter: BallPulseFooter(
                  key: new GlobalKey<RefreshFooterState>(),
                  color: primarySwatchColor,
                ),
                onRefresh: () async {
                  _refresh();
                },
                autoLoad: true,
                loadMore: () async {
                  _getHotProducts(false);
                },
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SlidesImage(
                          slides: homeEntity.data.slides,
                        ),
                        NavigateCategory(
                          categorys: homeEntity.data.category,
                        ),
                        AdBanner(
                          advertesPicture: homeEntity.data.advertesPicture,
                        ),
                        MallInfo(
                          shopInfo: homeEntity.data.shopInfo,
                        ),
                        Promotion(
                          saoma: homeEntity.data.saoma,
                          integralMallPic: homeEntity.data.integralMallPic,
                          newUser: homeEntity.data.newUser,
                        ),
                        ProductRecommend(
                          recommends: recommends,
                        ),
                        ProductFloor(
                          floorPic: homeEntity.data.floor1Pic,
                          floor: homeEntity.data.floor1,
                        ),
                        ProductFloor(
                          floorPic: homeEntity.data.floor2Pic,
                          floor: homeEntity.data.floor2,
                        ),
                        ProductFloor(
                          floorPic: homeEntity.data.floor3Pic,
                          floor: homeEntity.data.floor3,
                        ),
                        _hotProductWrap(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: InkWell(
                  child: Text(
                    '${homeEntity.message}\n\n点击重试',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => _refresh(),
                ),
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
              child: Text(
                '加载中...',
                style: TextStyle(color: Colors.grey,),
              ),
            );
          }
        },
        //接口获取首页信息
        future: _homeFuture,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///火爆商品
  int _page = 1;
  List<HotProduct> _hotProducts = [];

  void _getHotProducts(bool isRefresh) {
    if (isRefresh) {
      _page = 1;
    }

    hotProducts(_page).then((onValue) {
      HotProductListEntity hotProductListEntity = onValue;
      if (hotProductListEntity.code == '0') {
        setState(() {
          if (isRefresh) {
            _hotProducts.clear();
          }
          _page++;
          _hotProducts.addAll(hotProductListEntity.data);
        });
      }
    });
  }

  Widget _hotProductWrap() {
    return Column(
      children: <Widget>[
        Container(
          color: primaryGrey,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            '火爆专区',
            style: TextStyle(
              color: primarySwatchColor,
              fontSize: sp_40,
            ),
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name,
                maxLines: 1,
                style: TextStyle(
                  fontSize: sp_36,
                  color: primarySwatchColor,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '￥${product.mallPrice}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: sp_34,
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                '￥${product.price}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.grey[400],
                  decoration: TextDecoration.lineThrough,
                  fontSize: sp_26,
                ),
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
            style: TextStyle(
              fontSize: sp_36,
            ),
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
      width: double.infinity,
      height: ScreenUtil().setWidth(484),
      padding: EdgeInsets.only(
        top: 12,
        bottom: 5,
      ),
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
        border: Border(
          top: BorderSide(width: 10, color: primaryGrey),
          bottom: BorderSide(width: 1, color: primaryGrey),
        ),
      ),
      child: Text(
        '商品推荐',
        style:
            TextStyle(color: Theme.of(context).primaryColor, fontSize: sp_40),
      ),
    );
  }

  //商品
  Widget _createItem(Recommend recommend) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: primaryGrey)),
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
            style: TextStyle(fontSize: sp_36),
          ),
          Text(
            '￥${recommend.price}',
            style: TextStyle(
                color: Colors.grey[400],
                decoration: TextDecoration.lineThrough,
                fontSize: sp_26),
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
      child: Column(
        children: <Widget>[
          _createFloorCategory(),
          _crateFloorProducts(),
        ],
      ),
    );
  }
}
