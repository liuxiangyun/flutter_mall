import 'package:flutter/material.dart';
import 'pages/index_page.dart';
import 'package:flutter_mall/res/color.dart';
import 'package:provide/provide.dart';
import 'package:flutter_mall/provides/second_level_category_provide.dart';
import 'package:flutter_mall/provides/category_product_provide.dart';
import 'package:fluro/fluro.dart';
import 'routes/application.dart';
import 'routes/routes.dart';

///provide 注册
final provides = Providers()
  ..provide(Provider.function((context) => SecondLevelCategoryProvide()))
  ..provide(Provider.function((context) => CategoryProductProvide()));

void main() => runApp(ProviderNode(child: MyApp(), providers: provides));

class MyApp extends StatelessWidget {
  MyApp() {
    //路由
    final router = Router();
    Application.router = router;
    Routes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '百姓生活+',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primarySwatch: primarySwatchColor,
      ),
      home: IndexPage(),
    );
  }
}
