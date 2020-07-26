import 'package:flutter/material.dart';
import 'package:mix/viewModel/VideoPlayViewModel.dart';
import 'package:provider/provider.dart';

class VideoDetailBottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoPlayViewModel>(context);
    return !provider.isFullscreen
        ? RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      child: Text("update data source"),
      onPressed: () {
        /// 更改视频播放链接DMEO

          // videoUrl = "https://www.runoob.com/try/demo_source/movie.mp4";

          provider.setVideoUrl("https://yun.zxziyuan-yun.com/20180221/4C6ivf8O/index.m3u8");
      },
    )
        : Container();
  }
}
