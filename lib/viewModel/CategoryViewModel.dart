import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/entity/CategoryGroup.dart';
import 'package:mix/entity/DataPage.dart';
import 'package:mix/entity/VideoSimple.dart';
import 'package:mix/model/tag.dart';
import 'package:mix/model/tag_group.dart';
import 'package:mix/model/video.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:mix/ui/widget/VideoCategoryPageWidget.dart';
import 'package:rxdart/rxdart.dart';

class CategoryViewModel extends ChangeNotifier {
  int pageSize = 10;
  int pageNum = 1;
  int selectId = -1;
  var params = DataHelper.getBaseMap();
  Map<int, Tag> selectTagMap = new Map();
  EasyRefreshController controller = EasyRefreshController();
  List<Video> videoList = List();

  CategoryViewModel(List<TagGroup> tagGroupList, this.selectId) {
    tagGroupList.forEach((element) {
      Tag tag = new Tag();
      tag.id = null;
      tag.groupId = element.tagList[0].groupId;
      tag.name = "全部";
      element.tagList.insert(0, tag);
      addSelectCategoryMap(element.tagList[0].groupId, tag);
      element.tagList.forEach((element) {
        if (element.id == this.selectId) {
          addSelectCategoryMap(element.groupId, element);
        }
      });
    });
  }

  addSelectCategoryMap(int key, dynamic value) {
    selectTagMap[key] = value;
  }

  final _model = CategoryPageModel();
  var response = BaseData();

  refresh() {
    pageSize = 10;
    pageNum = 1;
    params["pageSize"] = pageSize;
    params["pageNum"] = pageNum;
    List<int> tagList = new List();
    selectTagMap.forEach((key, value) {
      if (value.id != null) {
        tagList.add(value.id);
      }
    });
    params["tagList"] =
        tagList.toString().replaceAll("[", "").replaceAll("]", "");
    _model.getVideoListByTag(params).doOnListen(() {}).listen((event) {
      //成功
      response = event;
      DataPage page = DataPage.fromJson(response.data);
      videoList.clear();
      page.data.forEach((element) {
        videoList.add(Video.fromJson(element));
      });
      controller.finishRefresh(success: true, noMore: page.size == 0);
//      controller.resetLoadState();
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
    List<int> tagList = new List();
    selectTagMap.forEach((key, value) {
      if (value.id != null) {
        tagList.add(value.id);
      }
    });
    params["tagList"] =
        tagList.toString().replaceAll("[", "").replaceAll("]", "");
    _model.getVideoListByTag(params).doOnListen(() {}).listen((event) {
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

class CategoryPageModel {
  Stream getVideoListByTag(params) => Stream.fromFuture(
      HttpManager.getInstance().get(Address.videoCategoryPageUrl, params));
}
