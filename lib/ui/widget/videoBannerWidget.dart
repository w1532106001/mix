import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mix/model/Banner.dart';
import 'package:mix/res/dimens.dart';

class VideoBannerWidget extends StatelessWidget {
  final VideoPageBanner banner;

  const VideoBannerWidget({Key key, this.banner}) : super(key: key);

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
                child: Image.network(
                  banner.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
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
                                banner.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimens.font_sp18),
                              ),
                              Text(
                                banner.description,
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
                            banner.score.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimens.font_sp18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
