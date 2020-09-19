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

class PersonIntroductionWidget extends BaseStatelessWidget {
  final Person _person;

  const PersonIntroductionWidget(this._person, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      padding: EdgeInsets.all(10),
//      height: 200,
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: _person.avatarUrl,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              width: 120,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: width - 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "姓名："+_person.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimens.font_sp18,
                  ),
                ),
                Html(
                  data: "简介：&nbsp;&nbsp;" +
                      (_person.introduction.length > 100
                          ? _person.introduction.substring(0, 100).trim() +
                              "..."
                          : _person.introduction.trim()),
                  style: {
                    "body": Style(
                      margin: EdgeInsets.all(0),
                      display: Display.BLOCK,
                    ),
                  },
                )
              ],
            ).padding(EdgeInsets.only(left: 10)),
          )
        ],
      ),
    );
  }
}
