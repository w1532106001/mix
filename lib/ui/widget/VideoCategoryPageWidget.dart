import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/entity/CategoryGroup.dart';
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
    String a = "";
    provider.selectCategoryMap.forEach((key, value) {
      a += value + ",";
    });
//    return Text("视频分页$a");
    return  EasyRefresh(
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //每行4个
            mainAxisSpacing: 20.0, //主轴方向间距
            crossAxisSpacing: 0.0, //水平方向间距
            childAspectRatio: 3/4, //纵轴缩放比例

          ),
          itemCount: provider.videoSimpleList.length,

          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new VideoDetailPage(
                            videoId: provider.videoSimpleList[index].videoId);
                      }))
                    },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: provider.videoSimpleList[index].thumbnailUrl,
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
                      child: Center(child:Text(
                        provider.videoSimpleList[index].videoName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp12),
                      )).padding(EdgeInsets.only(top: 10)),
                    ),
                  ],
                ));
          }),
      controller: provider.controller,
      onRefresh: () async {
        provider.refresh();
      },
      onLoad: () async {
        provider.load();
      },
//      scrollController: videoSearchViewProvider.scrollController,
    );
  }
}
