import 'package:flutter/material.dart';
import 'package:flutter_mall/model/category_entity.dart';

class SecondLevelCategoryProvide with ChangeNotifier {
  List<SecondLevelCategory> _secondLevelCategorys = [];

  SecondLevelCategoryProvide();

  List<SecondLevelCategory> get secondLevelCategorys => _secondLevelCategorys;

  set secondLevelCategorys(List<SecondLevelCategory> list) {
    _secondLevelCategorys.clear();
    //服务器没返回"全部"二级分类，客户端自行添加
    if (list.isNotEmpty) {
      SecondLevelCategory all =
          SecondLevelCategory("", list[0].mallCategoryId, "全部", "");
      _secondLevelCategorys.add(all);
    }
    _secondLevelCategorys.addAll(list);
    notifyListeners();
  }
}
