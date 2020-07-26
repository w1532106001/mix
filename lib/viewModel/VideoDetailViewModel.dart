import 'package:flutter/cupertino.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

class VideoDetailViewModel extends ChangeNotifier {
  final _model = VideoDetailDataModel();
  var response = BaseData();
  int state = VideoModelState.notRequested; // 0 未请求，1 正在请求， 2 请求成功， 3请求失败
  var params = DataHelper.getBaseMap();

  int videoId = 0;

  getVideoDetailData() {
    /// 不为 0 说明上一条请求未完成，直接退出
    if (state != VideoModelState.notRequested) return;
    params["videoId"] = videoId.toString();
    _model.getVideoHomePageData(params).doOnListen(() {
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

  VideoDetailViewModel() {
    getVideoDetailData();
  }
}

class VideoDetailDataModel {

  Stream getVideoHomePageData(params) => Stream.fromFuture(
      HttpManager.getInstance().post(Address.videoDetailDataUrl, params));
}
