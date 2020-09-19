import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/entity/person.dart';
import 'package:mix/model/banner.dart' as VideoBanner;
import 'package:mix/res/dimens.dart';
import 'package:mix/common/extension.dart';
import 'package:mix/ui/view/videoDetailPage.dart';

class PersonVideoListWidget extends BaseStatelessWidget {
  final Person _person;

  const PersonVideoListWidget(this._person, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    if(_person.videoList.length>0){
      return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, //每行4个
            mainAxisSpacing: 20.0, //主轴方向间距
            crossAxisSpacing: 0.0, //水平方向间距
            childAspectRatio: 3/4, //纵轴缩放比例

          ),
          itemCount: _person.videoList.length,

          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) {
                    return new VideoDetailPage(_person.videoList[index].id);
                  }))
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: _person.videoList[index].coverUrl,
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
                        _person.videoList[index].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white, fontSize: Dimens.font_sp12),
                      )).padding(EdgeInsets.only(top: 10)),
                    ),
                  ],
                ));
          });
    }else{
      return Container(
        child: Center(child: Text("暂无视频"),),
      );
    }

  }
}
