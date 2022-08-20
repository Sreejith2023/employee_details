import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_data/controllers/home_controller.dart';
import 'package:employee_data/model/employees_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: SafeArea(
        child: loadEmployeesData(),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: Container(
        width: double.infinity,
        height: 40,
        color: Colors.white,
        child: Center(
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              controller.setSearchKeyword(value);
            },
            decoration: const InputDecoration(
              hintText: 'Search name or email',
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
        ),
      ),
    );
  }

  loadEmployeesData() {
    return Obx(() {
      return controller.getIsLoading()? loadingWidget(): controller.filteredResponse.value.isEmpty
          ? noRecordsWidget()
          : ListView.builder(
              itemCount: controller.filteredResponse.value.length,
              itemBuilder: (context, i) {
                return employeeItem(
                    context, controller.filteredResponse.value[i]);
              });
    });
  }

  Widget employeeItem(BuildContext context, EmployeesResponseModel employee) {
    return InkWell(
      onTap: () {
        controller.setSelectedEmployee(employee);
        FocusScope.of(context).unfocus();
        Get.toNamed('/details');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Card(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 150),
              child: Row(
                children: [
                  profileImage(employee),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5, right: 5, bottom: 2),
                          child: Text(
                            employee.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 2, right: 5, bottom: 5),
                          child: Text(
                            employee.company == null
                                ? "Nill"
                                : employee.company!.name!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget profileImage(EmployeesResponseModel employee) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ClipOval(
        child: CachedNetworkImage(
          height: 90,
          width: 90,
          imageUrl: employee.profileImage!,
          placeholder: (context, url) => Image.asset(
            'asset/images/avatar.png',
            fit: BoxFit.scaleDown,
            height: 100,
            width: 200,
          ),
          errorWidget: (context, url, error) => Image.asset(
            'asset/images/avatar.png',
            fit: BoxFit.scaleDown,
            height: 100,
            width: 200,
          ),
        ),
      ),
    );
  }

  noRecordsWidget() {
    return const Center(
      child: Text(
        "No Records",
        style: TextStyle(),
      ),
    );
  }

  loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
