import 'package:employee_data/bindings/data_bindings.dart';
import 'package:employee_data/pages/details_page.dart';
import 'package:employee_data/pages/home_page.dart';
import 'package:get/get.dart';

class AppRoutes{
  static final routes = [
    GetPage(
      name: '/home',
      page: () => HomePage(),
      binding: DataBindings(),
      transition: Transition.rightToLeft
    ),

    GetPage(
        name: '/details',
        page: () => DetailsPage(),
        binding: DataBindings(),
        transition: Transition.rightToLeft
    ),
  ];
}