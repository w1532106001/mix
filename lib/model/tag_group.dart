import 'package:mix/model/tag.dart';

class TagGroup {
  //标签组名称
  String groupName;

  //标签列表
  List<Tag> tagList;

  TagGroup({this.groupName, this.tagList});

  TagGroup.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    if (json['tagList'] != null) {
      tagList = new List<Tag>();
      json['tagList'].forEach((v) {
        tagList.add(new Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    if (this.tagList != null) {
      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
