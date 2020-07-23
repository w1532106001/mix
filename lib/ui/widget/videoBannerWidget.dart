import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/entity/VideoHomePageBanner.dart';
import 'package:mix/res/dimens.dart';
import 'package:mix/ui/view/videoSearchPage.dart';

class VideoBannerWidget extends BaseStatelessWidget {
  final VideoHomePageBanner videoHomePageBanner;

  const VideoBannerWidget(this.videoHomePageBanner, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double shadowHeight = 50;
    double bannerHeight = 300;

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: Stack(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: bannerHeight,
                  child: CachedNetworkImage(
                    imageUrl: videoHomePageBanner.imageUrl,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                    fit: BoxFit.fill,
                  )),
              //   Image.network(
              //     videoHomePageBanner.imageUrl,
              //     fit: BoxFit.fill,
              //   ),
              // ),
              Padding(
                  padding: EdgeInsets.only(top: bannerHeight - 80),
                  child: ClipRect(
                      //可裁切的矩形
                      child: BackdropFilter(
                          //背景过滤器
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Opacity(
                              opacity: 0.2, //透明度,数值越大越不透明
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                    //盒子修饰器
                                    color: Colors.grey.shade100),
                              ))))),
              Padding(
                padding: EdgeInsets.only(top: bannerHeight - 80),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                videoHomePageBanner.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimens.font_sp18),
                              ),
                              Text(
                                videoHomePageBanner.description,
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: Dimens.font_sp12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: Dimens.gap_dp16),
                          alignment: Alignment.centerRight,
                          child: Text(
                            videoHomePageBanner.score.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimens.font_sp18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.search),
                  onPressed: () => {
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new VideoSearchPage();
                    }))
                  },
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          "assets/images/index_shadow_top.png",
          height: shadowHeight,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.only(top: bannerHeight - shadowHeight),
          child: Image.asset(
            "assets/images/index_shadow_bottom.png",
            height: shadowHeight,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        )
      ],
    );
  }
}
