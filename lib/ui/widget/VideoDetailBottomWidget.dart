import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mix/model/cast_member.dart';
import 'package:mix/model/collection.dart';
import 'package:mix/model/tag.dart';
import 'package:mix/model/video.dart';
import 'package:mix/model/video_detail_page.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/view/videoDetailPage.dart';
import 'package:mix/ui/view/videoSearchPage.dart';
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
            margin:
                EdgeInsets.only(left: Dimens.gap_dp10, right: Dimens.gap_dp10),
            height: MediaQuery.of(context).size.height - 256,
            child: ListView(
              children: getVideoColumnListWidgetList(video,
                  videoDetailPageModel.collectionList, context, provider),
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
      Video video,
      List<Collection> videoColumnList,
      BuildContext context,
      VideoPlayViewModel provider) {
    List<Widget> widgetList = List();
    String tags = "";
    video.tagList.forEach((element) {
      tags += element.name + " ";
    });
    widgetList.add(Text(
      video.name,
      style: TextStyle(
          color: Colors.black,
          fontSize: Dimens.font_sp20,
          fontWeight: FontWeight.bold),
    ));
    widgetList.add(RichText(
      text: TextSpan(
          text: '${video.ratingNum}分',
          style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp16),
          children: getTagsTextSpanWidget(context, video.tagList)),
    ));
    widgetList.add(ChangeNotifierProvider(
        create: (context) => VideoDetailBottomViewModel(),
        child: Consumer<VideoDetailBottomViewModel>(
            builder: (_, videoDetailBottomViewModel, __) =>
                videoDetailBottomViewModel.isShowIntroduction
                    ? Html(
                        data: "简介：&nbsp;&nbsp;" +
                            video.introduction.trim() +
                            " <a>收起</a>",
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
                          text: "简介：  " +
                              video.introduction.substring(0, 53).trim(),
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
    widgetList.add(GestureDetector(
      child: Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Text(
                  video.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_sp18,
                  ),
                ),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
      onTap: () {
        var maxHeight = MediaQuery.of(context).size.height * (8 / 16);
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return new Container(
                  height: maxHeight,
                  child: ChangeNotifierProvider(
                    create: (context) => VideoModalBottomSheetViewModel(
                        videoDetailPageModel.seriesList[0].videoList, video),
                    child: Consumer<VideoModalBottomSheetViewModel>(
                        builder: (_, videoModalBottomSheetViewModel, __) =>
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  height: 30,
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: videoDetailPageModel
                                        .seriesList[0].videoList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: Text(
                                                videoDetailPageModel
                                                    .seriesList[0]
                                                    .videoList[index]
                                                    .name,
                                                style: TextStyle(
                                                    color: Color(0xff898989),
                                                    fontSize: Dimens.font_sp20,
                                                    fontWeight:
                                                        videoModalBottomSheetViewModel
                                                                    .video.id ==
                                                                videoDetailPageModel
                                                                    .seriesList[
                                                                        0]
                                                                    .videoList[
                                                                        index]
                                                                    .id
                                                            ? FontWeight.bold
                                                            : FontWeight
                                                                .normal))
                                            .padding(EdgeInsets.only(
                                                left: 10, right: 10)),
                                        onTap: () {
                                          videoModalBottomSheetViewModel
                                              .setSelectVideoId(
                                                  videoDetailPageModel
                                                      .seriesList[0]
                                                      .videoList[index]
                                                      .id);
                                          print('123132');
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: maxHeight - 40,
                                  child: GridView.builder(
                                      padding: EdgeInsets.all(10),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5, //每行三列
                                        mainAxisSpacing: 10.0, //主轴方向间距
                                        crossAxisSpacing: 10.0, //水平方向间距
                                        childAspectRatio: 1.0, //纵轴缩放比例
                                      ),
                                      itemCount: video.episodeList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: Center(
                                              child: Text(
                                                  videoModalBottomSheetViewModel
                                                      .video
                                                      .episodeList[index]
                                                      .name),
                                            ),
                                          ),
                                          onTap: () => {
                                            Navigator.pop(context),
                                            if (video.id ==
                                                videoModalBottomSheetViewModel
                                                    .video.id)
                                              {
                                                provider.setEpisodeId(
                                                    video.episodeList[index].id)
                                              }
                                            else
                                              {
                                                Navigator.pushReplacement(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (_) {
                                                  return new VideoDetailPage(
                                                      videoModalBottomSheetViewModel
                                                          .selectVideoId,
                                                      episodeId: video
                                                          .episodeList[index]
                                                          .id);
                                                }))
                                              }
                                            //是当前视频替换播放地址 不是就重新加载页面
                                          },
                                        );
                                      }),
                                ),
                              ],
                            )),
                  ));
            });
      },
    ));
    widgetList.add(Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: video.episodeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              margin: EdgeInsets.only(right: 10),
              child: Center(
                child: Text(video.episodeList[index].name),
              ),
            ),
            onTap: () {
              provider.setEpisodeId(video.episodeList[index].id);
            },
          );
        },
      ),
    ));

    List<CastMember> castMemberList = List();
    castMemberList.addAll(video.directorList);
    castMemberList.addAll(video.starList);
    castMemberList.addAll(video.writerList);
    widgetList.add(Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: castMemberList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: castMemberList[index].avatarUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                  child: Text(
                    castMemberList[index].type==0?"导演":castMemberList[index].type==1?"编剧":"演员",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              Positioned(
                bottom: 0,
                width: 80,
                child: Center(
                  child: Text(
                    castMemberList[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));

    videoColumnList.forEach((element) {
      widgetList.add(VideoHorizontalList(
        element,
        isNeedPadding: false,
      ));
    });
    return widgetList;
  }

  List<TextSpan> getTagsTextSpanWidget(BuildContext context, List<Tag> tags) {
    List<TextSpan> tagWidgets = new List();
    tags.forEach((element) {
      tagWidgets.add(TextSpan(
          text: " ${element.name}",
          style: TextStyle(color: Colors.blue, fontSize: Dimens.font_sp16),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(context, new MaterialPageRoute(builder: (_) {
                return new VideoSearchPage(
                  tagId: element.id,
                );
              }));
            }));
    });
    return tagWidgets;
  }
}

class VideoDetailBottomViewModel extends ChangeNotifier {
  var isShowIntroduction = false;

  setShowIntroduction(bool b) {
    isShowIntroduction = b;
    notifyListeners();
  }
}

class VideoModalBottomSheetViewModel extends ChangeNotifier {
  var selectVideoId = -1;
  var video;
  var v;
  List<Video> videoList;

  setSelectVideoId(int videoId) {
    selectVideoId = videoId;
    videoList.forEach((element) {
      if (element.id == videoId) {
        this.video = element;
      }
    });
    notifyListeners();
  }

  VideoModalBottomSheetViewModel(this.videoList, this.v) {
    videoList.forEach((element) {
      if (element.id == this.v.id) {
        this.video = element;
      }
    });
  }
}
