import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/model/video.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/view/videoDetailPage.dart';
import 'package:mix/viewModel/CategoryViewModel.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';
import 'package:mix/common/extension.dart';

class VideoCategoryPageWidget extends StatelessWidget {
  VideoCategoryPageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);

    return EasyRefresh(
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //每行4个
            mainAxisSpacing: 20.0, //主轴方向间距
            crossAxisSpacing: 0.0, //水平方向间距
            childAspectRatio: 3 / 4, //纵轴缩放比例
          ),
          itemCount: provider.videoList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new VideoDetailPage(
                            provider.videoList[index].id);
                      }))
                    },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: provider.videoList[index].coverUrl,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                        width: 80,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Center(
                          child: Text(
                        provider.videoList[index].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp12),
                      )).padding(EdgeInsets.only(top: 10)),
                    ),
                  ],
                ));
          }),
      controller: provider.controller,
      firstRefresh: true,
      onRefresh: () async {
        provider.refresh();
      },
      onLoad: () async {
        provider.load();
      },

      header: ClassicalHeader(
        refreshText: "下拉刷新",
        refreshReadyText: "松开刷新",
        refreshingText: "刷新中",
        refreshedText: "刷新完成",
        refreshFailedText: "刷新失败",
        noMoreText: "没有更多了",
        showInfo: false,
      ),
      footer: ClassicalFooter(
          loadText: "上拉加载",
          loadReadyText: "松开加载",
          loadingText: "加载中",
          loadedText: "加载完成",
          loadFailedText: "加载失败",
          noMoreText: "没有更多了",
          showInfo: false,
          enableInfiniteLoad:false //这个参数会解决第一次触发onload的问题
      ),
//      scrollController: videoSearchViewProvider.scrollController,
    );
  }

}
class VideoCategoryViewModel extends ChangeNotifier {
  List<Video> videoList = List();
  setVideoList(List<Video> list){
    this.videoList = list;
  }
}
