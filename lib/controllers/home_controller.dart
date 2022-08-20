
import 'package:employee_data/model/employees_response_model.dart';
import 'package:employee_data/remote/remote_data_provider.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController{
  final _employeeBox = Hive.box('employees_box');
  RxString _searchKeyword = "".obs;
  RxList<EmployeesResponseModel> employeesResponseModel = RxList.empty(growable: true);
  RxList<EmployeesResponseModel> filteredResponse = RxList.empty(growable: true);
  EmployeesResponseModel? selectedEmployee;
  RxBool isLoading = false.obs;

  setIsLoading(bool value){
    isLoading.value = value;
  }

  getIsLoading(){
    return isLoading.value;
  }
  String getSearchKeyword(){
    return _searchKeyword.value;
  }

  setSelectedEmployee(EmployeesResponseModel model) {
    selectedEmployee = model;
  }

  EmployeesResponseModel getSelectedEmployee(){
    return selectedEmployee!;
  }

  setSearchKeyword(String keyword){
    _searchKeyword.value = keyword;
    filteredResponse.clear();
    fetchEmployees();
  }
  callEmployeesApi(){
  //  fetchEmployees();
    setIsLoading(true);
    RemoteDataProvider dataProvider =RemoteDataProvider.instance;
    dataProvider.getEmployeesData().then((value) {
      setIsLoading(false);
     print("Employees_data $value");
     addEmployees(value);
    });
  }

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  addEmployees(EmployeeResponseList newitem){
    newitem.empList!.forEach((e) async{
      await _employeeBox.add(e);
    });

    fetchEmployees();
  }

  fetchEmployees(){
    print("list_keys ${_employeeBox.keys}");
    if(_employeeBox.keys.isEmpty){
      callEmployeesApi();
    }else{
      _employeeBox.values.where((element) {
        EmployeesResponseModel qw = EmployeesResponseModel.fromJson(element);
        if(qw.name!.toLowerCase().contains(getSearchKeyword()) || qw.email!.toLowerCase().contains(getSearchKeyword())){
          return true;
        }else{
          return false;
        }
      }
      ).forEach((element) {
        print("db_value123 ${element.toString()}");
        EmployeesResponseModel qw =EmployeesResponseModel.fromJson(element);
        employeesResponseModel.value.add(qw);
        filteredResponse.value.add(qw);
        filteredResponse.refresh();
        //   print("db_value ${emp.toString()}");

      });
    }
    /*final data = _employeeBox.keys.forEach((key) {
       var emp  = _employeeBox.get(key) ;
       EmployeesResponseModel qw =EmployeesResponseModel.fromJson(emp);
      employeesResponseModel.value.add(qw);
   //   print("db_value ${emp.toString()}");
      if(_employeeBox.keys.isEmpty){
        callEmployeesApi();
      }
     // countdownController = CountdownController(autoStart: false);
     // controllerList.add(countdownController!);

     // return "";
    //  return {'key': key, 'title': value['title'], 'description': value['description'] , 'actual_duration': value['actual_duration'], 'remaining_duration': value['remaining_duration'], 'status': value['status'], 'last_logged_time': value['last_logged_time']};
    });*/
  }
}