import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:flutter_mall/res/color.dart';

void main() => runApp(MyApp());

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
