import 'package:flutter/material.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                return SingleChildScrollView(
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
                        leaderImage: data['data']['shopInfo']['leaderImage'],
                        leaderPhone: data['data']['shopInfo']['leaderPhone'],
                      )
                    ],
                  ),
                );
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
          future: getIndexContent(),
        ));
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
      width: double.infinity,
      height: ScreenUtil().setWidth(500),
      child: Swiper.children(
        children: images
            .map((url) => FadeInImage.assetNetwork(
                  placeholder: 'images/banner_placeholder.png',
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
          FadeInImage.assetNetwork(
            placeholder: 'images/banner_placeholder',
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

  AdBanner({Key key, this.adPicUrl})
      : assert(adPicUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setWidth(151),
      child: FadeInImage.assetNetwork(
        placeholder: 'images/banner_placeholder',
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

  ShopInfo({Key key, this.leaderImage, this.leaderPhone})
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
        width: double.infinity,
        height: ScreenUtil().setWidth(358),
        child: FadeInImage.assetNetwork(
          placeholder: 'images/banner_placeholder',
          image: leaderImage,
          fit: BoxFit.fill,
        ),
      ),
      onTap: () => _launchPhone(),
    );
  }
}
