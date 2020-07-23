import 'package:flutter/material.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/ui/widget/videoBannerWidget.dart';
import 'package:mix/ui/widget/videoHorizontalList.dart';
import 'package:mix/viewModel/VideoHomePageViewModel.dart';
import 'package:provider/provider.dart';

class VideoHomePage extends BaseStatelessWidget {
  const VideoHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoHomePageViewModel>(context);
    if (provider.state != 2) {
      return SafeArea(
        top: true,
        child: (provider.state == 1)
            ? showLoading()
            : (provider.state == 3)
                ? showError()
                : Scaffold(
                    backgroundColor: Color.fromARGB(255, 43, 42, 50),
                    body: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        VideoBannerWidget(),
                        VideoHorizontalList(),
                        VideoHorizontalList(),
                        VideoHorizontalList(),
                        VideoHorizontalList(),
                      ],
                    ),
                  ),
      );
    }
  }
}
