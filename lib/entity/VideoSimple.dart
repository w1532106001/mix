class VideoSimple {
  int videoId;
  String thumbnailUrl;
  String videoName;
  
  VideoSimple({this.videoId, this.thumbnailUrl, this.videoName});

  VideoSimple.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    thumbnailUrl = json['thumbnailUrl'];
    videoName = json['videoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['videoName'] = this.videoName;
    return data;
  }
}
