import 'package:mix/model/video.dart';

class Collection {
  String name;
  List<Video> videoList;

  Collection({this.name, this.videoList});

  Collection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['videoList'] != null) {
      videoList = new List<Video>();
      json['videoList'].forEach((v) {
        videoList.add(new Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.videoList != null) {
      data['videoList'] = this.videoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
