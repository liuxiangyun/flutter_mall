import 'package:flutter/material.dart';
import 'package:flutter_mall/model/product_detail_entity.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mall/res/font.dart';
import 'package:flutter_mall/res/color.dart';

class ProductDetailPage extends StatelessWidget {
  final tabs = ['详情', '评论'];
  final String productId;

  ProductDetailPage(this.productId);

  Widget buildLeading(BuildContext context, bool innerBoxIsScrolled) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: innerBoxIsScrolled
          ? Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
          : CircleAvatar(
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              backgroundColor: Color(0x00918B81),
            ),
    );
  }

  Widget _sliverAppBar(BuildContext context, ProductDetailEntity entity,
      bool innerBoxIsScrolled) {
    return SliverAppBar(
      leading: buildLeading(context, innerBoxIsScrolled),
      title: Text(innerBoxIsScrolled ? entity.data.goodInfo.goodsName : ''),
      pinned: true,
      expandedHeight: ScreenUtil().setWidth(1560),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  width: double.infinity,
                  height: ScreenUtil().setWidth(1000),
                  placeholder: kTransparentImage,
                  image: entity.data.goodInfo.image1,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    entity.data.goodInfo.goodsName,
                    style: TextStyle(
                      fontSize: sp_45,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Text(
                    '编号：${entity.data.goodInfo.goodsSerialNumber}',
                    style: TextStyle(
                      fontSize: sp_40,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '￥${entity.data.goodInfo.presentPrice.toString()}',
                        style: TextStyle(
                            fontSize: sp_45, color: primarySwatchColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '市场价：￥${entity.data.goodInfo.oriPrice}',
                          style: TextStyle(
                            fontSize: sp_36,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: ScreenUtil().setWidth(170),
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 10, color: lightGrey),
                    bottom: BorderSide(width: 10, color: lightGrey),
                  )),
                  child: Text(
                    '说明：> 急速送达 > 正品保证',
                    style: TextStyle(color: Colors.deepOrangeAccent, fontSize: sp_40),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottom: TabBar(
          unselectedLabelColor:
              innerBoxIsScrolled ? Colors.white70 : Colors.grey[400],
          labelColor: innerBoxIsScrolled ? Colors.white : Colors.redAccent,
          indicatorColor: innerBoxIsScrolled ? Colors.white : Colors.redAccent,
          tabs: tabs
              .map(
                (tab) => Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    tab,
                    style: TextStyle(fontSize: sp_45),
                  ),
                ),
              )
              .toList()),
      forceElevated: innerBoxIsScrolled,
    );
  }

  Widget _tabView(
      ProductDetailEntity entity, String tab, BuildContext context) {
    return CustomScrollView(
        // key 保证唯一性
        key: PageStorageKey<String>(tab),
        slivers: <Widget>[
          // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          //TODO html
          SliverFillRemaining(
            child: Html(data: entity.data.goodInfo.goodsDetail),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetailEntity>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProductDetailEntity entity = snapshot.data;
            if (snapshot.data.code == '0') {
              return DefaultTabController(
                length: tabs.length,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) =>
                      <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      child: _sliverAppBar(context, entity, innerBoxIsScrolled),
                    )
                  ],
                  body: TabBarView(
                    // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                    // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                    children: tabs
                        .map(
                          (tab) => Builder(
                              builder: (context) =>
                                  _tabView(entity, tab, context)),
                        )
                        .toList(),
                  ),
                ),
              );
            } else {
              return Center(
                child: InkWell(
                  child: Text(
                    '${entity.message}\n\n点击重试',
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => _refresh(),
                ),
              );
            }
          } else if (snapshot.hasError) {
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
            return Center(
              child: Text(
                '加载中...',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          }
        },
        future: productDetail(productId),
      ),
    );
  }

  void _refresh() {}
}
