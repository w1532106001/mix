class Tag {
  int id;
  //组id
  int groupId;
  //名称
  String name;
  Tag({this.id, this.groupId, this.name});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['groupId'] = this.groupId;
    data['name'] = this.name;
    return data;
  }
}
