import 'package:flutter/material.dart';
import 'package:mix/common/baseStatelessWidget.dart';

class VideoDetailPage extends BaseStatelessWidget {
  final int videoId;
  const VideoDetailPage({this.videoId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 43, 42, 50),
            body: Stack(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      "https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2614500706.webp",
                      fit: BoxFit.cover,
                    )),
              ],
            )));
  }
}
