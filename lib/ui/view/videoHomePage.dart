import 'package:flutter/material.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/entity/VideoColumn.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/ui/widget/videoBannerWidget.dart';
import 'package:mix/ui/widget/videoHorizontalList.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class VideoHomePage extends BaseStatelessWidget {
  const VideoHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 42, 50),
          body: _view(context),
        ));
  }

  Widget _view(BuildContext context) {
    final provider = Provider.of<VideoHomePageViewModel>(context);

    switch (provider.state) {
      case 1:
        return showLoading();
      case 2:
        //请求成功拿到response 解析实体类
        if (provider.response.code == 0) {
          var videoHomePageData =
              VideoHomePageData.fromJson(provider.response.data);
          return ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              VideoBannerWidget(videoHomePageData.banner),
              ListView.builder(
                physics:
                    new NeverScrollableScrollPhysics(), //加上这句话，widget就不会滑动了
                shrinkWrap: true,
                itemCount: videoHomePageData.videoColumnList.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoHorizontalList(
                          videoHomePageData.videoColumnList[index])
                      .padding(EdgeInsets.only(top: index == 0 ? 0 : 20));
                },
              ),
            ],
          );
        } else {
          return GestureDetector(
            child: showErrorWithMessage(provider.response.message,true),
            onTap: () => {
              provider.state = VideoModelState.notRequested,
              provider.getVideoHomePageData()
            },
          );
        }
        break;
      case 3:
        return GestureDetector(
          child: showError(true),
          onTap: () => {
            provider.state = VideoModelState.notRequested,
            provider.getVideoHomePageData()
          },
        );
    }
  }

  List<Widget> getVideoColumnListWidgetList(List<VideoColumn> videoColumnList) {
    List<Widget> widgetList = List();
    videoColumnList.forEach((element) {
      widgetList.add(VideoHorizontalList(element));
    });
    return widgetList;
  }
}
