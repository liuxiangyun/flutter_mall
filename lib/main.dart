import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:provide/provide.dart';
import 'package:flutter_mall/provide/second_level_category_provide.dart';

final provides = Providers()
  ..provide(Provider.function((context) => SecondLevelCategoryProvide()));

void main() => runApp(ProviderNode(child: MyApp(), providers: provides));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
      ),
      home: IndexPage(),
    );
  }
}
