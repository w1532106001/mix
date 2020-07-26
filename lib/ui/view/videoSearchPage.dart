import 'package:flutter/material.dart';
import 'package:mix/viewModel/VideoSearchResultViewModel.dart';
import 'file:///C:/Users/25082/flutterCode/mix/lib/ui/widget/VideoCategoryWidget.dart';
import 'file:///C:/Users/25082/flutterCode/mix/lib/ui/widget/VideoSearchResultWidget.dart';
import 'package:mix/viewModel/VideoSearchViewModel.dart';
import 'package:provider/provider.dart';
import 'package:synchronized/extension.dart';

///输入搜索词时替换 分割线已下区域 输入框为空时正常展示分页视频
class VideoSearchPage extends StatelessWidget {
  const VideoSearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoSearchViewModel = VideoSearchViewModel();
    return Scaffold(
      appBar: AppBar(title: Text("搜索")),
      backgroundColor: Color.fromARGB(255, 43, 42, 50),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<VideoSearchViewModel>(
                create: (context) => videoSearchViewModel),
            ChangeNotifierProvider<VideoSearchResultViewModel>(
                create: (context) => VideoSearchResultViewModel(
                    videoSearchViewModel.searchWordController)),
          ],
          child: _VideoSearchPageColumn(),
        ),
      ),
    );
  }
}

class _VideoSearchPageColumn extends StatelessWidget {
  const _VideoSearchPageColumn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VideoSearchViewModel>(context);
    final videoSearchResultViewProvider =
        Provider.of<VideoSearchResultViewModel>(context);

    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            // 未获得焦点下划线设为灰色
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            //获得焦点下划线设为蓝色
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
          controller: provider.searchWordController,
          onChanged: (v) {
            provider.onInput();
            videoSearchResultViewProvider.onInputRefresh();
          },
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: provider.isSearch
                  ? VideoSearchResultWidget()
                  : VideoCategoryWidget(),
//          ),
            ))
      ],
    );
  }
}
