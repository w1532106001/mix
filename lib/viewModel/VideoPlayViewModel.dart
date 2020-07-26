import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mix/common/VideoModelState.dart';
import 'package:mix/entity/BaseListData.dart';
import 'package:mix/entity/DataPage.dart';
import 'package:mix/entity/VideoHomePageData.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/entity/VideoSimple.dart';
import 'package:mix/net/address.dart';
import 'package:mix/net/data_helper.dart';
import 'package:mix/net/http_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'CategoryViewModel.dart';

class VideoPlayViewModel extends ChangeNotifier {
  var params = DataHelper.getBaseMap();
  String videoUrl = "https://www.runoob.com/try/demo_source/movie.mp4";

  // String videoUrl = "https://yun.zxziyuan-yun.com/20180221/4C6ivf8O/index.m3u8";
  // String videoUrl = "http://vodkgeyttp8.vod.126.net/cloudmusic/1241/core/e30b/aec700ee466da6c8ce51d12953e7b89f.mp4?wsSecret=a6d7342a3ea018d632b3d7ce56ffd11f&wsTime=1580815486";
  // String videoUrl = "http://vod.anyrtc.cc/364c01b9c8ca4e46bd65e7307887341d/34688ef93da349628d5e4efacf8a5167-9fd7790c8f5862b09c350e4a916b203d.mp4";

  String mainSubtitles = ""; //主字幕
  String subSubtitles = ""; //辅字幕
  bool _isPlaying = false;
  bool isFullscreen = false;

  bool showAdvertCover = false; //是否显示广告

  bool get isPlaying => _isPlaying;

  set isPlaying(bool playing) {
    print("playing  $playing");
    _isPlaying = playing;
    notifyListeners();
  }


  setVideoUrl(String url){
    videoUrl = url;
    notifyListeners();
  }

  setShowAdvertCover(bool showAdvertCover){
    this.showAdvertCover = showAdvertCover;
    notifyListeners();
  }
  setFullscreen(bool isFullscreen){
    this.isFullscreen = isFullscreen;
    notifyListeners();
  }
  VideoPlayViewModel();

  final _model = VideoSearchResultModel();
  var response = BaseData();
}

class VideoSearchResultModel {
  Stream getVideoSearchPage(params) => Stream.fromFuture(
      HttpManager.getInstance().post(Address.videoSearchPageUrl, params));
}
