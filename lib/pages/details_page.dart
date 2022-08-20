import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_data/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DetailsPage extends GetView<HomeController> {
  const DetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                profileImage(),
                detailsRow(
                  label: 'Name',
                  value: controller.selectedEmployee!.name!,
                ),
                detailsRow(
                  label: 'UserName',
                  value: controller.selectedEmployee!.username!,
                ),
                detailsRow(
                  label: 'Email',
                  value: controller.selectedEmployee!.email!,
                ),
                detailsRow(
                  label: 'Phone',
                  value: controller.selectedEmployee!.phone!,
                ),
                detailsRow(
                  label: 'Website',
                  value: controller.selectedEmployee!.website!,
                ),
                subHead('Address Details'),
                detailsRow(
                  label: 'Street',
                  value: controller.selectedEmployee!.address!.street!,
                ),
                detailsRow(
                  label: 'Suite',
                  value: controller.selectedEmployee!.address!.suite!,
                ),
                detailsRow(
                  label: 'City',
                  value: controller.selectedEmployee!.address!.city!,
                ),
                detailsRow(
                  label: 'Zipcode',
                  value: controller.selectedEmployee!.address!.zipcode!,
                ),
                companyDetails()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileImage() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        child: ClipOval(
          child: CachedNetworkImage(
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: controller.selectedEmployee!.profileImage!,
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
      ),
    );
  }

  Widget detailsRow({required String label, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 1,
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              )),
          Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }

  Widget companyDetails() {
    if (controller.getSelectedEmployee().company != null) {
      return Column(
        children: [
          subHead('Company Details'),
          detailsRow(
              label: 'Name',
              value: controller.selectedEmployee!.company!.name!),
          detailsRow(
              label: 'CatchPhrase',
              value: controller.selectedEmployee!.company!.catchPhrase!),
          detailsRow(
              label: 'BS', value: controller.selectedEmployee!.company!.bs!),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget subHead(String label) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ));
  }
}
