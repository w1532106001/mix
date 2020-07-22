import 'package:flutter/material.dart';
import 'package:mix/model/IndexVideoRecommend.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/view/videoDetailPage.dart';
import 'package:mix/common/extension.dart';

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
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    indexVideoRecommend.videoTuhmbnailList.add(videoThumbnail2);
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            indexVideoRecommend.name,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp18),
          ),
          Container(
            height: 180,
            padding: EdgeInsets.only(top: 20),
            child: ListView.builder(
              shrinkWrap: true, //解决 listview 嵌套报错
              // physics: NeverScrollableScrollPhysics(), //禁用滑动事件
              scrollDirection: Axis.horizontal,
              itemCount: indexVideoRecommend.videoTuhmbnailList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (_) {
                            return new VideoDetailPage(
                                videoId: indexVideoRecommend
                                    .videoTuhmbnailList[index].videoId);
                          }))
                        },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            indexVideoRecommend
                                .videoTuhmbnailList[index].videoThumbnailUrl,
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          indexVideoRecommend
                              .videoTuhmbnailList[index].videoName,
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimens.font_sp12),
                        ).padding(EdgeInsets.only(top: 10))
                      ],
                    )).padding(EdgeInsets.only(left: (index == 0 ? 0 : 20)));
              },
            ),
          )
        ],
      ),
    );
  }
}
