import 'package:flutter/cupertino.dart';
import 'package:mix/entity/VideoHomePageBanner.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

class VideoHomePageViewModel extends ChangeNotifier {
  final _model = VideoHomePageDataModel();
  var banner = VideoHomePageData();
  int state = 0; // 0 未请求，1 正在请求， 2 请求成功， 3请求失败
  getVideoHomePageData() {
    /// 不为 0 说明上一条请求未完成，直接退出
    if (state != 0) return;

    _model.getVideoHomePageData().doOnListen(() {
      state = 1;
      notifyListeners();
    }).listen((event) {
      //成功

      /// 返回值为0，请求成功
      state = 2;
      banner = event.data;
      notifyListeners();

    }, onError: (e) {
      state = 3;
      notifyListeners();
      //失败
      print('onError--------------------------------:$e');
    });
  }

  VideoHomePageViewModel() {
    getVideoHomePageData();
  }
}

class VideoHomePageDataModel {
  VideoHomePageData videoPageBanner = new VideoHomePageData();
  var params = DataHelper.getBaseMap();

  Stream getVideoHomePageData() => Stream.fromFuture(
      HttpManager.getInstance().get(Address.videoHomePageDataUrl, params));
}
