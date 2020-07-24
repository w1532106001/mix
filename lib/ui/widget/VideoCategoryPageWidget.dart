import 'package:flutter/material.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/viewModel/CategoryViewModel.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';

class VideoCategoryPageWidget extends StatelessWidget {

  VideoCategoryPageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryViewModel>(context);
    String a ="";
    provider.selectCategoryMap.forEach((key, value) {
    a+=value+",";
    });
    return Text("视频分页$a");
  }
}
