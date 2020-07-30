class CastMember {
  //人id
  int personId;

  //人名
  String name;

  //头像地址
  String avatarUrl;

  //人物介绍
  String introduction;

  //0 导演 1编剧 2演员
  int type;

  CastMember(
      {this.personId, this.name, this.avatarUrl, this.introduction, this.type});

  CastMember.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
    introduction = json['introduction'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    data['introduction'] = this.introduction;
    data['type'] = this.type;
    return data;
  }
}
