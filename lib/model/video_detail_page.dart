import 'package:mix/model/video.dart';

import 'collection.dart';

class VideoDetailPage {
  Video video;
  List<Collection> collectionList;
  List<Collection> seriesList;

  VideoDetailPage({this.video, this.collectionList, this.seriesList});

  VideoDetailPage.fromJson(Map<String, dynamic> json) {
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
    if (json['collectionList'] != null) {
      collectionList = new List<Collection>();
      json['collectionList'].forEach((v) {
        collectionList.add(new Collection.fromJson(v));
      });
    }
    if (json['seriesList'] != null) {
      seriesList = new List<Collection>();
      json['seriesList'].forEach((v) {
        seriesList.add(new Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    if (this.collectionList != null) {
      data['collectionList'] =
          this.collectionList.map((v) => v.toJson()).toList();
    }
    if (this.seriesList != null) {
      data['seriesList'] = this.seriesList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
