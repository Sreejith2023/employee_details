import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor{

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Base_Url_Option '+options.path);
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("Error "+err.message);
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("Api_Response "+response.data.toString());
    return super.onResponse(response, handler);
  }
}