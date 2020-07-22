import 'package:flutter/material.dart';
import 'package:mix/model/IndexVideoRecommend.dart';
import 'package:mix/res/dimens.dart';

class VideoHorizontalList extends StatelessWidget {
  const VideoHorizontalList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoThumbnail = new VideoThumbnail();
    videoThumbnail.videoId = 1;
    videoThumbnail.videoName = "123";
    videoThumbnail.videoThumbnailUrl =
        "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2614500706.webp";

    var videoThumbnail2 = new VideoThumbnail();
    videoThumbnail2.videoId = 2;
    videoThumbnail2.videoName = "456";
    videoThumbnail2.videoThumbnailUrl =
        "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2614500706.webp";

    IndexVideoRecommend indexVideoRecommend = new IndexVideoRecommend();
    indexVideoRecommend.name = "title";
    indexVideoRecommend.videoTuhmbnailList = new List();
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);

    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: <Widget>[
          Text(
            indexVideoRecommend.name,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp16),
          ),
          new Expanded(
            child: ListView.builder(
              shrinkWrap: true, //解决 listview 嵌套报错
              // physics: NeverScrollableScrollPhysics(), //禁用滑动事件
              scrollDirection: Axis.horizontal,
              itemCount: indexVideoRecommend.videoTuhmbnailList.length,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 50,
                  child: Text("123"),
                );
              },
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
