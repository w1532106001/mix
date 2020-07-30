
class DataPage {
  int total;
  List<dynamic> data;
  int pageNum;
  int pageSize;
  int size;
  int startRow;
  int endRow;
  int pages;
  int prePage;
  int nextPage;
  bool isFirstPage;
  bool isLastPage;
  bool hasPreviousPage;
  bool hasNextPage;
  int navigatePages;
  List<int> navigatepageNums;
  int navigateFirstPage;
  int navigateLastPage;

  DataPage(
      {this.total,
        this.data,
        this.pageNum,
        this.pageSize,
        this.size,
        this.startRow,
        this.endRow,
        this.pages,
        this.prePage,
        this.nextPage,
        this.isFirstPage,
        this.isLastPage,
        this.hasPreviousPage,
        this.hasNextPage,
        this.navigatePages,
        this.navigatepageNums,
        this.navigateFirstPage,
        this.navigateLastPage});

  DataPage.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    data = json['list'];
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    pages = json['pages'];
    prePage = json['prePage'];
    nextPage = json['nextPage'];
    isFirstPage = json['isFirstPage'];
    isLastPage = json['isLastPage'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    navigatePages = json['navigatePages'];
    navigatepageNums = json['navigatepageNums'].cast<int>();
    navigateFirstPage = json['navigateFirstPage'];
    navigateLastPage = json['navigateLastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['list'] = this.data;
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['size'] = this.size;
    data['startRow'] = this.startRow;
    data['endRow'] = this.endRow;
    data['pages'] = this.pages;
    data['prePage'] = this.prePage;
    data['nextPage'] = this.nextPage;
    data['isFirstPage'] = this.isFirstPage;
    data['isLastPage'] = this.isLastPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['navigatePages'] = this.navigatePages;
    data['navigatepageNums'] = this.navigatepageNums;
    data['navigateFirstPage'] = this.navigateFirstPage;
    data['navigateLastPage'] = this.navigateLastPage;
    return data;
  }
}