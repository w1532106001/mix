import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mix/entity/BaseData.dart';
import 'package:mix/entity/BaseListData.dart';
import 'package:mix/net/result_data.dart';
import 'package:convert/convert.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;

    
      if (option.contentType != null && option.contentType.contains("text")) {
        return response.data;
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        if(response.data['data'] is List){
          BaseListData baseListData = BaseListData.fromJson(response.data);
          return baseListData;
        }else{
          BaseData baseData = BaseData.fromJson(response.data);
          return baseData;
        }

      }

  }
  @override
  Future onError(DioError err) {
    return super.onError(err);
  }
}
