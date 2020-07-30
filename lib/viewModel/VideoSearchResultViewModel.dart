import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/entity/BaseListData.dart';
import 'package:mix/entity/DataPage.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/entity/VideoSimple.dart';
import 'package:mix/model/video.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'CategoryViewModel.dart';

class VideoSearchResultViewModel extends ChangeNotifier {

  int pageSize = 10;
  int pageNum = 1;
  var params = DataHelper.getBaseMap();
  TextEditingController searchWordController;

  Map<int, dynamic> selectCategoryMap = new Map();
  EasyRefreshController controller = EasyRefreshController();
  List<Video> videoList = List();

  VideoSearchResultViewModel(this.searchWordController);



  final _model = VideoSearchResultModel();
  var response = BaseData();
  onInputRefresh() {
    if (searchWordController.text.trim().isNotEmpty) {
        refresh();
    }

  }

  refresh() {
    pageSize = 10;
    pageNum = 1;
    params["pageSize"] = pageSize;
    params["pageNum"] = pageNum;
    params["searchWord"] = searchWordController.text;
    _model.getVideoSearchPage(params).doOnListen(() {}).listen((event) {
      //成功
      response = event;
      DataPage page = DataPage.fromJson(response.data);
      videoList.clear();
      page.data.forEach((element) {
        videoList.add(Video.fromJson(element));
      });
      controller.finishRefresh(success: true,noMore: page.size==0);
      controller.resetLoadState();
      pageNum++;
      notifyListeners();
    }, onError: (e) {
      //失败
      print('onError--------------------------------:$e');
      controller.finishRefresh(success: false);

    });
  }

  load() {
    params["pageSize"] = pageSize;
    params["pageNum"] = pageNum;
    params["searchWord"] = searchWordController.text;
    _model.getVideoSearchPage(params).doOnListen(() {}).listen((event) {
      //成功
      response = event;
      DataPage page = DataPage.fromJson(response.data);
      page.data.forEach((element) {
        videoList.add(Video.fromJson(element));
      });
      controller.finishLoad(noMore: !page.hasNextPage);
      pageNum++;
      notifyListeners();
    }, onError: (e) {
      //失败
      print('onError--------------------------------:$e');
      controller.finishLoad(success: false);
      notifyListeners();
    });
  }
}

class VideoSearchResultModel {

  Stream getVideoSearchPage(params) => Stream.fromFuture(
      HttpManager.getInstance().get(Address.videoSearchPageUrl, params));
}
