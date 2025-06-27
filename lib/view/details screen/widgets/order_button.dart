import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../order/view/order_screen.dart';
import '../../widgets/custom_button_service.dart/service_button.dart';

Widget orderButton() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 4),
    child: Center(
        child: ServiceButton(
      title: 'اطلب الان',
      onPressed: () => Get.off(OrderScreen()),
    )),
  );
}
