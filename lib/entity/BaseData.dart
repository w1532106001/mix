class BaseData{
  String message;
  int code;
  Map<String,dynamic> data;
  BaseData.fromJson(Map<String,dynamic> json){
    message = json['message'];
    code = json['code'];
    data = json['data'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}