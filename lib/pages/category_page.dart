import 'package:flutter/material.dart';
import 'package:flutter_mall/model/category_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mall/res/font.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:flutter_mall/http/api_server.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import 'package:flutter_mall/provide/second_level_category_provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  Future _categoryFuture = category();

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
            var srcJson = json.decode(snapshot.data.toString());
            CategoryEntity categoryEntity = CategoryEntity.fromJson(srcJson);

            if (categoryEntity.code == '0') {
              return Row(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: ScreenUtil().setWidth(270),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: primaryGrey,
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
                          height: ScreenUtil().setWidth(100),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: primaryGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(categoryEntity.message),
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
          color: _clickIndex == _index ? primaryGrey : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: primaryGrey),
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
      //第一次进入时右侧显示默认二级分类
      Provide.value<SecondLevelCategoryProvide>(context).secondLevelCategorys =
          widget.firstLevelCategorys[0].secondLevelCategory;
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
  List<SecondLevelCategory> _secondLevelCategorys =
      new List<SecondLevelCategory>();

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
}
