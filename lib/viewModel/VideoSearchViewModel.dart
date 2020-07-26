import 'package:flutter/cupertino.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/entity/BaseListData.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

class VideoSearchViewModel extends ChangeNotifier {
  final _model = VideoSearchModel();
  var response = BaseListData();
  int state = VideoModelState.notRequested; // 0 未请求，1 正在请求， 2 请求成功， 3请求失败
  var searchWordController = TextEditingController();
  bool isSearch = false;

  ScrollController scrollController = new ScrollController();
  bool isShowTop = true;

  Map<int, dynamic> selectCategoryMap = new Map();

  onInput() {
    if (searchWordController.text.isNotEmpty) {
      isSearch = true;

    } else {
      isSearch = false;
    }
    notifyListeners();
  }

  getCategoryGroupList() {
    /// 不为 0 说明上一条请求未完成，直接退出
    if (state != VideoModelState.notRequested) return;

    _model.getCategoryGroupList().doOnListen(() {
      state = VideoModelState.requesting;
      notifyListeners();
    }).listen((event) {
      //成功
      state = VideoModelState.requestSucceeded;
      response = event;
      notifyListeners();
    }, onError: (e) {
      state = VideoModelState.requestfailed;
      notifyListeners();
      //失败
      print('onError--------------------------------:$e');
    });
  }

//  initScrollHeight(){
//    scrollController.;
//  }

  VideoSearchViewModel() {
    scrollController.addListener(() {
//      var tempSsShowTop = scrollController.offset >= 1000;
//
//      if (tempSsShowTop != isShowTop) {
//        isShowTop = tempSsShowTop;
//        this.notifyListeners();
//      }

    });

    getCategoryGroupList();
  }

  addSelectCategoryMap(int key, dynamic value) {
    selectCategoryMap[key] = value;
    notifyListeners();
  }
}

class VideoSearchModel {
  var params = DataHelper.getBaseMap();

  Stream getCategoryGroupList() => Stream.fromFuture(
      HttpManager.getInstance().get(Address.categoryGroupListUrl, params));
}
