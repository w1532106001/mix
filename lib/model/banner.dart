class Banner {
  int videoId;
  String name;
  String introduction;
  String bannerUrl;
  double ratingNum;

  Banner(
      {this.videoId,
      this.name,
      this.introduction,
      this.bannerUrl,
      this.ratingNum});

  Banner.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
    name = json['name'];
    introduction = json['introduction'];
    bannerUrl = json['bannerUrl'];
    ratingNum = json['ratingNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoId'] = this.videoId;
    data['name'] = this.name;
    data['introduction'] = this.introduction;
    data['bannerUrl'] = this.bannerUrl;
    data['ratingNum'] = this.ratingNum;
    return data;
  }
}
