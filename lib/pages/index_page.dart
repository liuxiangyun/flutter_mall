import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final Map<String, IconData> items = {
    '首页': Icons.home,
    '分类': Icons.category,
    '购物车': Icons.shopping_cart,
    '会员中心': Icons.person,
  };
  final List<Widget> pages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  final List<BottomNavigationBarItem> bottomNavigationBarItems = List();
  int _currentIndex;

  @override
  void initState() {
    super.initState();
    items.forEach((title, icon) {
      bottomNavigationBarItems.add(BottomNavigationBarItem(
        title: Text(title),
        icon: Icon(
          icon,
        ),
      ));
    });
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    //app第一个页面传入设计稿尺寸
    ScreenUtil(width: 750, height: 1334)..init(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }
}
