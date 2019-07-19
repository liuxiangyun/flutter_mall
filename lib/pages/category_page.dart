import 'package:flutter/material.dart';
import 'package:flutter_mall/model/category_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mall/res/font.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'package:provide/provide.dart';
import 'package:flutter_mall/provides/second_level_category_provide.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_mall/model/category_product_list_entity.dart';
import 'package:flutter_mall/event/flutter_event_bus.dart';
import 'package:flutter_mall/event/category_product_event.dart';
import 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_mall/routes/routes.dart';

///分类
class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  Future<CategoryEntity> _categoryFuture = category();

  void _refresh() {
    setState(() {
      _categoryFuture = category();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CategoryEntity categoryEntity = snapshot.data;

            if (categoryEntity.code == '0') {
              return Row(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: ScreenUtil().setWidth(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: lightGrey,
                        ),
                      ),
                    ),
                    child: LeftFirstLevelCategory(
                        firstLevelCategorys: categoryEntity.firstLevelCategory),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TopSecondLevelCategory(),
                          height: ScreenUtil().setWidth(110),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: lightGrey,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: CategoryProductList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: InkWell(
                  child: Text(
                    '${categoryEntity.message}\n\n点击重试',
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
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          }
        },
        //接口获取首页信息
        future: _categoryFuture,
      ),
    );
  }
}

///左侧一级分类
class LeftFirstLevelCategory extends StatefulWidget {
  final List<FirstLevelCategory> firstLevelCategorys;

  LeftFirstLevelCategory({Key key, @required this.firstLevelCategorys})
      : super(key: key);

  @override
  FirstLevelCategoryState createState() => FirstLevelCategoryState();
}

class FirstLevelCategoryState extends State<LeftFirstLevelCategory> {
  bool _isFirst = true;

  //默认选择第一个一级分类
  int _clickIndex = 0;

  ///创建一级分类item
  Widget _createItem(
      BuildContext context, FirstLevelCategory firstLevelCategory) {
    int _index = widget.firstLevelCategorys.indexOf(firstLevelCategory);

    return InkWell(
      onTap: () {
        setState(() {
          _clickIndex = _index;
        });
        Provide.value<SecondLevelCategoryProvide>(context)
            .secondLevelCategorys = firstLevelCategory.secondLevelCategory;
      },
      child: Container(
        height: ScreenUtil().setWidth(150),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _clickIndex == _index ? lightGrey : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: lightGrey),
          ),
        ),
        child: Text(
          firstLevelCategory.mallCategoryName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: sp_36,
              color: _clickIndex == _index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.title.color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirst) {
      //默认选择第一个一级分类
      if (widget.firstLevelCategorys.isNotEmpty) {
        Provide.value<SecondLevelCategoryProvide>(context)
                .secondLevelCategorys =
            widget.firstLevelCategorys[0].secondLevelCategory;
      }
      _isFirst = false;
    }

    return ListView.builder(
      itemBuilder: (context, index) => _createItem(
        context,
        widget.firstLevelCategorys[index],
      ),
      itemCount: widget.firstLevelCategorys.length,
    );
  }
}

///顶部二级分类
// ignore: must_be_immutable
class TopSecondLevelCategory extends StatefulWidget {
  List<SecondLevelCategory> _secondLevelCategorys = [];

  TopSecondLevelCategory({Key key}) : super(key: key);

  @override
  TopSecondLevelCategoryState createState() => TopSecondLevelCategoryState();
}

class TopSecondLevelCategoryState extends State<TopSecondLevelCategory> {
  int _clickIndex = 0;

  ///创建二级分类item
  Widget _createItem(
      BuildContext context, SecondLevelCategory secondLevelCategory) {
    int _index = widget._secondLevelCategorys.indexOf(secondLevelCategory);

    return InkWell(
      onTap: () {
        setState(() {
          _clickIndex = _index;
        });
        notifyCategoryProductList(context, secondLevelCategory);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Text(
          secondLevelCategory.mallSubName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: sp_36,
              color: _clickIndex == _index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.title.color),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<SecondLevelCategoryProvide>(
        builder: (context, child, secondLevelCategoryProvide) {
          //默认选择了一级分类，或者切换了一级分类
          if (widget._secondLevelCategorys.isEmpty ||
              widget._secondLevelCategorys[0].mallCategoryId !=
                  secondLevelCategoryProvide
                      .secondLevelCategorys[0].mallCategoryId) {
            _clickIndex = 0;
            notifyCategoryProductList(
                context, secondLevelCategoryProvide.secondLevelCategorys[0]);
          }

          widget._secondLevelCategorys.clear();
          widget._secondLevelCategorys
              .addAll(secondLevelCategoryProvide.secondLevelCategorys);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _createItem(
                context,
                widget._secondLevelCategorys[index],
              );
            },
            itemCount: widget._secondLevelCategorys.length,
          );
        },
      ),
    );
  }

  ///通知分类商品列表刷新
  notifyCategoryProductList(
      BuildContext context, SecondLevelCategory secondLevelCategory) {
    //不使用provide 更新状态
//    Provide.value<CategoryProductProvide>(context).secondLevelCategory =
//        secondLevelCategory;

    //使用event_bus 发送指定事件
    FlutterEventBus().eventBus.fire(CategoryProductEvent(secondLevelCategory));
  }
}

///分类商品列表
class CategoryProductList extends StatefulWidget {
  @override
  CategoryProductListState createState() => CategoryProductListState();
}

class CategoryProductListState extends State<CategoryProductList> {
  SecondLevelCategory _secondLevelCategory;
  int _page = 1;
  List<CategoryProduct> _categoryProducts = [];
  StreamSubscription _categoryProductSubscription;

  CategoryProductListState() {
    //注册指定事件监听
    _categoryProductSubscription =
        FlutterEventBus().eventBus.on<CategoryProductEvent>().listen((event) {
      //默认选择了二级分类，或者切换了一级或者二级分类
      if (_secondLevelCategory == null ||
          _secondLevelCategory.mallCategoryId !=
              event.secondLevelCategory.mallCategoryId ||
          _secondLevelCategory.mallSubId !=
              event.secondLevelCategory.mallSubId) {
        _secondLevelCategory = event.secondLevelCategory;
        _getCategoryProductList(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    //取消监听
    _categoryProductSubscription.cancel();
  }

  Widget _createCategoryProduct(CategoryProduct product) {
    return InkWell(
      onTap: () => Routes.navigateToProductDetail(context, product.goodsId),
      child: Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(415),
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
                  product.goodsName,
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
                    '￥${product.presentPrice}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: sp_34,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  '￥${product.oriPrice}',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //不使用provide 更新状态，因为build里面需要访问网络拿到数据再setState，但setState后又会调用build,一直循环重复
//    return Provide<CategoryProductProvide>(
//      builder: (context, child, categoryProductProvide) {
//        _secondLevelCategory = categoryProductProvide.secondLevelCategory;
//        if (_secondLevelCategory != null) {
//          _getCategoryProductList();
//        }
//        return child;
//      },
//      child: SingleChildScrollView(
//        child: Wrap(
//          children: _categoryProducts
//              .map((product) => _createCategoryProduct(product))
//              .toList(),
//        ),
//      ),
//    );

    return EasyRefresh(
      refreshHeader: MaterialHeader(
        key: new GlobalKey<RefreshHeaderState>(),
      ),
      refreshFooter: BallPulseFooter(
        key: new GlobalKey<RefreshFooterState>(),
        color: primarySwatchColor,
      ),
      onRefresh: () => _getCategoryProductList(true),
      loadMore: () => _getCategoryProductList(false),
      autoLoad: true,
      child: SingleChildScrollView(
        child: _categoryProducts.isEmpty
            ? Center(
                child: Text(
                  '暂无数据',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            : Wrap(
                children: _categoryProducts
                    .map((product) => _createCategoryProduct(product))
                    .toList(),
              ),
      ),
    );
  }

  ///获取分类商品列表
  _getCategoryProductList(bool isRefresh) {
    if (isRefresh) {
      setState(() {
        _categoryProducts.clear();
        _page = 1;
      });
    }

    categoryProductList(_secondLevelCategory.mallCategoryId,
            _secondLevelCategory.mallSubId, _page)
        .then((onValue) {
      CategoryProductListEntity categoryProductListEntity = onValue;
      if (categoryProductListEntity.code == "0") {
        _page++;
        setState(() {
          if (categoryProductListEntity.data != null) {
            _categoryProducts.addAll(categoryProductListEntity.data);
          }
        });
      }
    });
  }
}
