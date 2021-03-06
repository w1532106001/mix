import 'package:dio/dio.dart';
import 'package:mix/entity/BaseData.dart';
import 'code.dart';
import 'dio_log_interceptor.dart';
import 'response_interceptor.dart';
import 'result_data.dart';
import 'address.dart';

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String baseUrl}) {
    if (null == _dio) {
      _dio = new Dio(
          new BaseOptions(baseUrl: Address.baseUrl, connectTimeout: 15000));
      _dio.interceptors.add(new DioLogInterceptor());
//      _dio.interceptors.add(new PrettyDioLogger());
      _dio.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Address.baseUrl) {
        _dio.options.baseUrl = Address.baseUrl;
      }
    }
    return this;
  }

  ///通用的GET请求
  get(api, params) async {
    Response response;
    try {
      response = await _dio.get(api, queryParameters: params);
    } on DioError catch (e) {
      throw e;
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///通用的POST请求
  post(api, params) async {
    Response response;

    try {
      response = await _dio.post(api, queryParameters: params);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }
}

BaseData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 666);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  BaseData baseData = new BaseData();
  baseData.message = errorResponse.statusMessage;
  baseData.code = errorResponse.statusCode;
  return baseData;
}
