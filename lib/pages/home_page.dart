import 'package:flutter/material.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                return Column(
                  children: <Widget>[
                    SwiperPicture(
                        data: slides
                            .map((slide) => slide['image'])
                            .toList()
                            .cast()),
                    NavigateCategory(
                      data: navCategorys,
                    ),
                  ],
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
class SwiperPicture extends StatelessWidget {
  final List<String> data;

  SwiperPicture({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(333),
      child: Swiper.children(
        children: data
            .map((url) => FadeInImage.assetNetwork(
                  placeholder: 'images/banner_placeholder.png',
                  image: url,
                  fit: BoxFit.fill,
                ))
            .toList(),
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
}

///导航分类
class NavigateCategory extends StatelessWidget {
  final List data;

  NavigateCategory({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  Widget _createItem({@required String picUrl, @required String picText}) {
    assert(picUrl != null &&
        picUrl.isNotEmpty &&
        picText != null &&
        picText.isNotEmpty);
    return InkWell(
      child: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
              placeholder: 'images/banner_placeholder', image: picUrl),
          Text(picText, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
      onTap: () {
        print('navigate category onTap');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
      child: GridView.count(
        crossAxisCount: 5,
        children: data.map((img) {
          _createItem(picUrl: img['image'], picText: img['text']);
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
      child: FadeInImage.assetNetwork(
          placeholder: 'images/banner_placeholder', image: adPicUrl),
    );
  }
}

///店长电话
class StoreManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
