import 'package:flutter/material.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/model/tag_group.dart';
import 'package:mix/viewModel/CategoryViewModel.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';

class CategoryListLineWidget extends StatelessWidget {
  final TagGroup tagGroup;

  CategoryListLineWidget(this.tagGroup, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);

    return Container(
        width: double.infinity,
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: tagGroup.tagList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: Container(
                    width: 50,
                    child: Text(
                      tagGroup.tagList[index].name,
                      style: TextStyle(
                          color: provider.selectTagMap[tagGroup.tagList[index].groupId] ==
                              tagGroup.tagList[index]
                              ? Colors.white
                              : Colors.white24),
                    ),
                  ),
                  onTap: () {
                    provider.addSelectCategoryMap(
                        tagGroup.tagList[index].groupId,
                        tagGroup.tagList[index]);
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    provider.refresh();
                  },
                ));
          },
        ));
  }
}
