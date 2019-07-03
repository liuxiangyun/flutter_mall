import 'package:flutter/material.dart';
import 'package:flutter_mall/model/category_entity.dart';

class CategoryProductProvide with ChangeNotifier {
  SecondLevelCategory _secondLevelCategory;

  set secondLevelCategory(SecondLevelCategory secondLevelCategory) {
    _secondLevelCategory = secondLevelCategory;
    notifyListeners();
  }

  SecondLevelCategory get secondLevelCategory {
    return _secondLevelCategory;
  }

  CategoryProductProvide();
}
