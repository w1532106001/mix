import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/entity/DataPage.dart';
import 'package:mix/entity/VideoSimple.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

class CategoryViewModel extends ChangeNotifier {
  int pageSize = 10;
  int currPage = 1;
  var params = DataHelper.getBaseMap();

  Map<int, dynamic> selectCategoryMap = new Map();
  EasyRefreshController controller = EasyRefreshController();
  List<VideoSimple> videoSimpleList = List();

  CategoryViewModel(List<CategoryGroup> categoryGroups) {
    categoryGroups.forEach((element) {
      addSelectCategoryMap(element.id, element.categoryList[0].name);
    });
  }

  addSelectCategoryMap(int key, dynamic value) {
    selectCategoryMap[key] = value;
  }

  final _model = CategoryPageModel();
  var response = BaseData();

  refresh() {
    pageSize = 10;
    currPage = 1;
    params["pageSize"] = pageSize;
    params["currPage"] = currPage;
    _model.getVideoHomePageData(params).doOnListen(() {}).listen((event) {
      //成功
      response = event;
      DataPage page = DataPage.fromJson(response.data);
      videoSimpleList.clear();
      page.data.forEach((element) {
        videoSimpleList.add(VideoSimple.fromJson(element));
      });
      controller.finishRefresh(success: true,noMore: !page.canLoad);
      controller.resetLoadState();
      notifyListeners();
    }, onError: (e) {
      //失败
      print('onError--------------------------------:$e');
      controller.finishRefresh(success: false);

    });
  }

  load() {
    currPage++;
    params["pageSize"] = pageSize;
    params["currPage"] = currPage;
    _model.getVideoHomePageData(params).doOnListen(() {}).listen((event) {
      //成功
      response = event;
      DataPage page = DataPage.fromJson(response.data);
      page.data.forEach((element) {
        videoSimpleList.add(VideoSimple.fromJson(element));
      });
      controller.finishLoad(noMore: !page.canLoad);
      notifyListeners();
    }, onError: (e) {
      //失败
      print('onError--------------------------------:$e');
      controller.finishLoad(success: false);
      notifyListeners();
    });
  }
}

class CategoryPageModel {
  Stream getVideoHomePageData(params) => Stream.fromFuture(
      HttpManager.getInstance().post(Address.videoCategoryPageUrl, params));
}
