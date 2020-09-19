import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/common/VideoModelState.dart';
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

class PersonViewModel extends ChangeNotifier {
  final int personId;

  final _model = PersonModel();
  var response = BaseData();
  int state = VideoModelState.notRequested; // 0 未请求，1 正在请求， 2 请求成功， 3请求失败
  getPersonData() {
    /// 不为 0 说明上一条请求未完成，直接退出
    if (state != VideoModelState.notRequested) return;

    _model.getPerson(personId).doOnListen(() {
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
  PersonViewModel(this.personId) {
    getPersonData();
  }





}

class PersonModel {
  var params = DataHelper.getBaseMap();
  Stream getPerson(personId) => Stream.fromFuture(
      HttpManager.getInstance().get(Address.personUrl+personId.toString(), params));
}
