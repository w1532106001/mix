class VideoEpisode {
  int id;

  // 名称
  String name;

  // 播放地址
  String playUrl;

  // 视频缩略图
  String thumbnailUrl;

  // 观看数
  int watchNum;

  VideoEpisode(
      {this.id, this.name, this.playUrl, this.thumbnailUrl, this.watchNum});

  VideoEpisode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    playUrl = json['playUrl'];
    thumbnailUrl = json['thumbnailUrl'];
    watchNum = json['watchNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['playUrl'] = this.playUrl;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['watchNum'] = this.watchNum;
    return data;
  }
}
