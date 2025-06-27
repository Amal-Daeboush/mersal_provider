import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefreshProductController extends GetxController {
  String name = 'اسم المنتج';
  String desc = 'وصف المنتج';
  String price = '100';
  String count = '4 قطع';
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    nameController.text=name;
    descController.text=desc;
    countController.text=count;
    priceController.text=price;
    super.onInit();
  }
}
