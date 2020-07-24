import 'package:flutter/material.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/viewModel/CategoryViewModel.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';

class CategoryListLineWidget extends StatelessWidget {
  final CategoryGroup categoryGroup;

  CategoryListLineWidget(this.categoryGroup, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);

    return Container(
        width: double.infinity,
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryGroup.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: Container(
                    width: 50,
                    child: Text(
                      categoryGroup.categoryList[index].name,
                      style: TextStyle(
                          color: provider.selectCategoryMap[categoryGroup
                                      .categoryList[index].categoryGroupId] ==
                                  categoryGroup.categoryList[index].name
                              ? Colors.white
                              : Colors.white24),
                    ),
                  ),
                  onTap: () {
                    provider.addSelectCategoryMap(
                        categoryGroup.categoryList[index].categoryGroupId,
                        categoryGroup.categoryList[index].name);
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    provider.notifyListeners();
                  },
                ));
          },
        ));
  }
}
