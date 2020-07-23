import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/entity/VideoColumn.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/view/videoDetailPage.dart';
import 'package:mix/common/extension.dart';

class VideoHorizontalList extends StatelessWidget {
  final VideoColumn videoColumn;
  const VideoHorizontalList(this.videoColumn, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            videoColumn.title,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp18),
          ),
          Container(
            height: 180,
            padding: EdgeInsets.only(top: 20),
            child: ListView.builder(
              shrinkWrap: true, //解决 listview 嵌套报错
              // physics: NeverScrollableScrollPhysics(), //禁用滑动事件
              scrollDirection: Axis.horizontal,
              itemCount: videoColumn.videoSimpleList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (_) {
                            return new VideoDetailPage(
                                videoId:
                                    videoColumn.videoSimpleList[index].videoId);
                          }))
                        },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                videoColumn.videoSimpleList[index].thumbnailUrl,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            videoColumn.videoSimpleList[index].videoName,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimens.font_sp12),
                          ).padding(EdgeInsets.only(top: 10)),
                        ),
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
