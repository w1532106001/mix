import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mix/model/collection.dart';
import 'package:mix/model/video.dart';
import 'package:mix/model/video_detail_page.dart';
import 'package:mix/ui/widget/videoHorizontalList.dart';
import 'package:mix/viewModel/VideoPlayViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class VideoDetailBottomWidget extends StatelessWidget {
  final VideoDetailPageModel videoDetailPageModel;

  VideoDetailBottomWidget(this.videoDetailPageModel, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoPlayViewModel>(context);
    final video = videoDetailPageModel.video;
    return !provider.isFullscreen
        ? Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height - 300,
            child: ListView(
              children: getVideoColumnListWidgetList(
                  video, videoDetailPageModel.collectionList),
            ))

//    RaisedButton(
//      color: Colors.blue,
//      textColor: Colors.white,
//      child: Text("update data source"),
//      onPressed: () {
//        /// 更改视频播放链接DMEO
//
//          // videoUrl = "https://www.runoob.com/try/demo_source/movie.mp4";
//
//          provider.setVideoUrl("https://yun.zxziyuan-yun.com/20180221/4C6ivf8O/index.m3u8");
//      },
//    )
        : Container();
  }

  List<Widget> getVideoColumnListWidgetList(
      Video video, List<Collection> videoColumnList) {
    List<Widget> widgetList = List();
    widgetList.add(Text(
      video.name,
      style: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ));
    widgetList.add(Text(
      "${video.ratingNum}分 · ${video.episodeList.length}集 · ${video.watchNum}次播放 · 简介  >",
      style: TextStyle(color: Colors.black, fontSize: 16),
    ).gesture(() => {print('点击简介')}));
    widgetList.add(Text("简介").padding(EdgeInsets.only(top: 5, bottom: 5)));
    widgetList.add(ChangeNotifierProvider(
        create: (context) => VideoDetailBottomViewModel(),
        child: Consumer<VideoDetailBottomViewModel>(
            builder: (_, videoDetailBottomViewModel, __) =>
                videoDetailBottomViewModel.isShowIntroduction
                    ? Html(
                        data: video.introduction.trim() + " <a>收起</a>",
                        onLinkTap: (url) => {
                          videoDetailBottomViewModel.setShowIntroduction(false)
                        },
                        style: {
                          "body": Style(
                            margin: EdgeInsets.all(0),
                            display: Display.BLOCK,
                          ),
                        },
                      )
                    : RichText(
                        text: TextSpan(
                          text: video.introduction.substring(0, 50).trim(),
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                                text: " 展开",
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    videoDetailBottomViewModel
                                        .setShowIntroduction(true);
                                  })
                          ],
                        ),
                      ))));
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border),
        ),
        IconButton(
          icon: Icon(Icons.file_download),
        ),
        IconButton(
          icon: Icon(Icons.share),
        ),
      ],
    ));
    widgetList.add(Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            video.name + "▼",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    ));
    widgetList.add(Container(
      height: 50,
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 50,
            height: 50,
            color: Colors.amber,
            margin: EdgeInsets.only(right: 10),
            child: Center(
              child: Text('123'),
            ).gesture(() => {
                  //todo点击播放所选集
                }),
          );
        },
      ),
    ));

    videoColumnList.forEach((element) {
      widgetList.add(VideoHorizontalList(element));
    });
    return widgetList;
  }
}

class VideoDetailBottomViewModel extends ChangeNotifier {
  var isShowIntroduction = false;

  setShowIntroduction(bool b) {
    isShowIntroduction = b;
    notifyListeners();
  }
}
