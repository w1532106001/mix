import 'package:mix/entity/VideoSimple.dart';

class VideoColumn {
  String title;
  List<VideoSimple> videoSimpleList;

  VideoColumn({this.title, this.videoSimpleList});

  VideoColumn.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['videoSimpleList'] != null) {
      videoSimpleList = new List<VideoSimple>();
      json['videoSimpleList'].forEach((v) {
        videoSimpleList.add(new VideoSimple.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.videoSimpleList != null) {
      data['videoSimpleList'] =
          this.videoSimpleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
