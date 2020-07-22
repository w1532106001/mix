import 'package:flutter/material.dart';
import 'package:mix/model/Banner.dart';
import 'package:mix/ui/widget/videoBannerWidget.dart';
import 'package:mix/ui/widget/videoHorizontalList.dart';

class VideoHomePage extends StatelessWidget {
  const VideoHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoPageBanner videoPageBanner = new VideoPageBanner(
        "title",
        "description",
        9.0,
        "https://puui.qpic.cn/media_img/lena/PICwqlyaq_580_1680/0");

    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 43, 42, 50),
          body: Column(
            children: <Widget>[
              VideoBannerWidget(
                banner: videoPageBanner,
              ),
              VideoHorizontalList()
            ],
          ),
        ));
  }
}
