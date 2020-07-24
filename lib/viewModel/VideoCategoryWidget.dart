import 'package:flutter/material.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';
class VideoCategoryWidget extends StatelessWidget {
  const VideoCategoryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoSearchViewModel>(context);

    return Text("分类");
  }
}
