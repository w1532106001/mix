import 'package:mix/entity/VideoColumn.dart';
import 'package:mix/entity/VideoHomePageBanner.dart';

class VideoHomePageData {
  VideoHomePageBanner banner;
  List<VideoColumn> videoColumnList;

  VideoHomePageData({this.banner, this.videoColumnList});

  VideoHomePageData.fromJson(Map<String, dynamic> json) {
    banner = json['banner'] != null
        ? new VideoHomePageBanner.fromJson(json['banner'])
        : null;
    if (json['videoColumnList'] != null) {
      videoColumnList = new List<VideoColumn>();
      json['videoColumnList'].forEach((v) {
        videoColumnList.add(new VideoColumn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner.toJson();
    }
    if (this.videoColumnList != null) {
      data['videoColumnList'] =
          this.videoColumnList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
