
class VideoHomePageBanner {

  String title;
  String description;
  double score;
  String imageUrl;
  VideoHomePageBanner({this.title, this.description, this.score, this.imageUrl});

  VideoHomePageBanner.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    score = json['score'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['score'] = this.score;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
