import 'package:dio/dio.dart';
import 'package:employee_data/model/employees_response_model.dart';

import 'api_interceptor.dart';

class RemoteDataProvider{
  final String BASE_URL = "http://www.mocky.io/v2/";

  RemoteDataProvider._privateConstructor();
  static final RemoteDataProvider _instance = RemoteDataProvider._privateConstructor();

  var dio = Dio();

  static RemoteDataProvider get instance => _instance;

  Future<EmployeeResponseList> getEmployeesData() async {
    dio.interceptors.add(ApiInterceptor());
   // dio.options.headers= {'Content-Type':'application/json'};
    Response data = await dio.get(BASE_URL+'5d565297300000680030a986'
      //   ,options: Options(contentType: 'application/json',
      // headers: {
      //   'accept':'*/*',
      //   'lancode':'en',
      //   'platform':'android',
      //   'appversion':'1.0.1',
      //   'timezone':'Asia/Kolkata'
      // },)
    );
    // print(data.data!.message);
    return EmployeeResponseList.fromJson(data.data);
  }

}