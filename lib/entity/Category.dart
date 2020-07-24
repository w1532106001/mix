class Category {
  int id;
  String name;
  int categoryGroupId;

  Category({this.id, this.name, this.categoryGroupId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryGroupId = json['categoryGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['categoryGroupId'] = this.categoryGroupId;
    return data;
  }
}