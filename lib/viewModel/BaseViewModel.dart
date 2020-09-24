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
import 'package:shared_preferences/shared_preferences.dart';

class BaseViewModel extends ChangeNotifier {

  String currentUser;

  final _baseModel = BaseModel();
  var response = BaseData();
  int state = VideoModelState.notRequested;

  BaseViewModel(){
    getUserCache();
  }
  // 0 未请求，1 正在请求， 2 请求成功， 3请求失败


  getUserCache() {
   _baseModel.getUser().doOnListen(() {
     //请求中
      state = VideoModelState.requesting;
      notifyListeners();
   }).listen((event) {
     state = VideoModelState.requestSucceeded;
     currentUser = event;
     notifyListeners();
   }, onError: (e) {
     //失败
     state = VideoModelState.requestfailed;
     notifyListeners();
     print('onError--------------------------------:$e');
   });
  }

  setUserCache(String user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }


}

class BaseModel {
  /// 获取缓存中用户
  Stream getUser() => Stream.fromFuture(
      SharedPreferences.getInstance().then((value) => value.getString('user'))
  );
}