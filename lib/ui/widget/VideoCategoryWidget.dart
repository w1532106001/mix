import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/entity/Category.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/model/tag_group.dart';
import 'package:mix/ui/widget/CategoryListLineWidget.dart';
import 'package:mix/ui/widget/VideoCategoryPageWidget.dart';
import 'package:mix/viewModel/CategoryViewModel.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';

class VideoCategoryWidget extends BaseStatelessWidget {
  final int tagId;
  const VideoCategoryWidget({this.tagId,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _view(context);
  }

  Widget _view(BuildContext context) {
    final provider = Provider.of<VideoSearchViewModel>(context);

    switch (provider.state) {
      case 1:
        return showLoading();
      case 2:
        //请求成功拿到response 解析实体类
        if (provider.response.code == 0) {
          List<TagGroup> tagGroupList = List();
          provider.response.data.forEach((element) {
            TagGroup tagGroup = TagGroup.fromJson(element);
            tagGroupList.add(tagGroup);
          });
          return ChangeNotifierProvider(
            create: (_) => CategoryViewModel(tagGroupList,this.tagId),
            child: NestedScrollView(
              controller: provider.scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    backgroundColor: Color.fromARGB(255, 43, 42, 50),
                    automaticallyImplyLeading: false,
                    floating: false,
                    pinned: true,
                    flexibleSpace: innerBoxIsScrolled
                        ? NestedScrollViewCenterTitle()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //加上这句话，widget就不会滑动了
                            itemCount: tagGroupList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryListLineWidget(
                                tagGroupList[index],
                              );
                            }),
                    expandedHeight: tagGroupList.length * 50.0,
                  )
                ];
              },
              body: VideoCategoryPageWidget(),
//              children: <Widget>[
//                ListView.builder(
//                    shrinkWrap: true,
//                    physics: new NeverScrollableScrollPhysics(),
//                    //加上这句话，widget就不会滑动了
//                    itemCount: categoryGroups.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      return CategoryListLineWidget(
//                        categoryGroups[index],
//                      );
//                    }),
//                Container(
//                  height: MediaQuery.of(context).size.height-500,
//                    child: VideoCategoryPageWidget()  )

//                Container()
            ),
          );
//        return Container();
        } else {
          return GestureDetector(
            child: showErrorWithMessage(provider.response.message, true),
            onTap: () => {
              provider.state = VideoModelState.notRequested,
              provider.getCategoryGroupList()
            },
          );
        }
        break;
      case 3:
        return GestureDetector(
          child: showError(true),
          onTap: () => {
            provider.state = VideoModelState.notRequested,
            provider.getCategoryGroupList()
          },
        );
    }
  }
}

class NestedScrollViewCenterTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoSearchViewModel>(context);
    final categoryViewModelProvider = Provider.of<CategoryViewModel>(context);

    String text = "";
    categoryViewModelProvider.selectTagMap.forEach((key, value) {
      text += value.name + "·";
    });
    return GestureDetector(
      child: Container(
          height: 30,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(text.substring(0, text.length - 1)),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          )),
      onTap: () {
        provider.scrollController.animateTo(.0,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
    );
  }
}
