import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mix/common/baseStatelessWidget.dart';
import 'package:mix/ui/widget/VideoDetailBottomWidget.dart';
import 'package:mix/ui/widget/videoPlayWidget.dart';
import 'package:mix/viewModel/VideoPlayViewModel.dart';
import 'package:provider/provider.dart';

class VideoDetailPage extends StatefulWidget {
  final int videoId;

  VideoDetailPage({this.videoId, Key key}) : super(key: key);

  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: ChangeNotifierProvider(
              create: (_) => VideoPlayViewModel(),
              child: Column(children: <Widget>[
                VideoPlayWidget(),
                //update data source
                VideoDetailBottomWidget(),
              ]))),
    );
  }
}
