import 'banner.dart';
import 'collection.dart';

class VideoHomePageData {
  Banner banner;
  List<Collection> collectionList;

  VideoHomePageData({this.banner, this.collectionList});

  VideoHomePageData.fromJson(Map<String, dynamic> json) {
    banner =
        json['banner'] != null ? new Banner.fromJson(json['banner']) : null;
    if (json['collectionList'] != null) {
      collectionList = new List<Collection>();
      json['collectionList'].forEach((v) {
        collectionList.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner.toJson();
    }
    if (this.collectionList != null) {
      data['collectionList'] =
          this.collectionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
