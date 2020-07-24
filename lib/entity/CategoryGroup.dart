import 'Category.dart';

class CategoryGroup {
  int id;
  String value;
  int type;
  List<Category> categoryList;

  CategoryGroup({this.id, this.value, this.type, this.categoryList});

  CategoryGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    type = json['type'];
    if (json['categoryList'] != null) {
      categoryList = new List<Category>();
      json['categoryList'].forEach((v) {
        categoryList.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['type'] = this.type;
    if (this.categoryList != null) {
      data['categoryList'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
