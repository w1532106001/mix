
class DataPage {
  int currPage;
  int pageSize;
  List<dynamic> data;
  bool canLoad;

  DataPage({this.currPage, this.pageSize, this.data, this.canLoad});

  DataPage.fromJson(Map<String, dynamic> json) {
    currPage = json['currPage'];
    pageSize = json['pageSize'];
    data = json['data'];
    canLoad = json['canLoad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currPage'] = this.currPage;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['canLoad'] = this.canLoad;
    return data;
  }
}