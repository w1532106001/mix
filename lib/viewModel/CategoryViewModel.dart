import 'package:flutter/cupertino.dart';
import 'package:mix/entity/CategoryGroup.dart';

class CategoryViewModel extends ChangeNotifier {
  Map<int, dynamic> selectCategoryMap = new Map();

  CategoryViewModel(List<CategoryGroup> categoryGroups) {
    categoryGroups.forEach((element) {
      addSelectCategoryMap(element.id, element.categoryList[0].name);
    });
  }

  addSelectCategoryMap(int key, dynamic value) {
    selectCategoryMap[key] = value;
  }
}
