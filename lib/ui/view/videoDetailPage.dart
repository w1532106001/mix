import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/model/video.dart';
import 'package:mix/model/video_detail_page.dart';
import 'package:mix/ui/widget/VideoDetailBottomWidget.dart';
import 'package:mix/ui/widget/videoPlayWidget.dart';
import 'package:mix/viewModel/VideoDetailViewModel.dart';
import 'package:mix/viewModel/VideoPlayViewModel.dart';
import 'package:provider/provider.dart';

class VideoDetailPage extends BaseStatelessWidget {
  final int videoId;

  const VideoDetailPage(this.videoId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 43, 42, 50),
            body: MultiProvider(
                providers: [
              ChangeNotifierProvider<VideoDetailViewModel>(
                  create: (context) => VideoDetailViewModel(this.videoId)),
              ChangeNotifierProvider<VideoPlayViewModel>(
                  create: (context) => VideoPlayViewModel()),
            ],
                child: Consumer<VideoDetailViewModel>(
                  builder: (_, videoDetailViewModel, __) =>
                      _view(context, videoDetailViewModel),
                ))));
  }

  Widget _view(
      BuildContext context, VideoDetailViewModel videoDetailViewModel) {
    final provider = videoDetailViewModel;

    switch (provider.state) {
      case 1:
        return showLoading();
      case 2:
        //请求成功拿到response 解析实体类
        if (provider.response.code == 0) {
          var videoDetailPageModel = VideoDetailPageModel.fromJson(provider.response.data);
          return Column(children: <Widget>[
            VideoPlayWidget(videoDetailPageModel.video),
            //update data source
            VideoDetailBottomWidget(videoDetailPageModel),
          ]);
        } else {
          return GestureDetector(
            child: showErrorWithMessage(provider.response.message, true),
            onTap: () => {
              provider.state = VideoModelState.notRequested,
              provider.getVideoDetailData(videoId)
            },
          );
        }
        break;
      case 3:
        return GestureDetector(
          child: showError(true),
          onTap: () => {
            provider.state = VideoModelState.notRequested,
            provider.getVideoDetailData(videoId)
          },
        );
    }
  }
}
