import 'package:flutter/material.dart';
import 'package:flutter_mall/model/category_entity.dart';

class SecondLevelCategoryProvide with ChangeNotifier {
  List<SecondLevelCategory> _secondLevelCategorys = List<SecondLevelCategory>();

  SecondLevelCategoryProvide();

  List<SecondLevelCategory> get secondLevelCategorys => _secondLevelCategorys;

  set secondLevelCategorys(List<SecondLevelCategory> list) {
    _secondLevelCategorys.clear();
    _secondLevelCategorys.addAll(list);
    notifyListeners();
  }
}
