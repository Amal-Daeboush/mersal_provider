import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/home/home%20product/controller/home_product_controller.dart';
import 'package:provider_mersal/view/home/home%20service/controller/home_services_controller.dart';

class DiscountController extends GetxController {
  final ProductModel productModel;

  DiscountController({required this.productModel});

  StatusRequest statusRequest = StatusRequest.none;

  TextEditingController descount = TextEditingController();
  TextEditingController firstDateDiscount = TextEditingController();
  TextEditingController lastDateDiscount = TextEditingController();

  @override
  void onInit() {
    descount.text = productModel.discountInfo.discountValue ?? '';
    firstDateDiscount.text =
        productModel.discountInfo.discountStartDate.toString();
    lastDateDiscount.text =
        productModel.discountInfo.discountEndDate.toString();
    super.onInit();
  }

  Future<void> EditDiscount(String id) async {
    if (descount.text.isEmpty ||
        firstDateDiscount.text.isEmpty ||
        lastDateDiscount.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى تعبئة جميع بيانات الخصم');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    final data = {"value": descount.text, "_method": "PUT"};

    final endpoint =
        productModel.providerableType == 'App\\Models\\Provider_Product'
            ? ApiLinks.updateProductDiscount
            : ApiLinks.updateServiceDiscount;

    var response = await ApiRemote().AddDiscountModel(data, endpoint, id);

    if (response == StatusRequest.success) {
      if (productModel.providerableType == 'App\\Models\\Provider_Product') {
        HomeProductController homeProductController = Get.find();
        homeProductController.getProduct();
      } else {
        HomeServicesController homeServicesController = Get.find();
        homeServicesController.getServices();
      }

      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  Future<void> ChangeStatusDiscount(String id) async {
    // يمكنك تنفيذ نفس منطق EditDiscount أو تخصيصه هنا لاحقًا
    await EditDiscount(id); // مثال فقط
  }

  Future<void> deleteDiscount(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    final endpoint =
        productModel.providerableType == 'App\\Models\\Provider_Product'
            ? ApiLinks.removeProductDiscount
            : ApiLinks.removeServiceDiscount;

    var response = await ApiRemote().deleteProductModel(endpoint, {}, id);

    if (response == StatusRequest.success) {
      if (productModel.providerableType == 'App\\Models\\Provider_Product') {
        HomeProductController homeProductController = Get.find();
        homeProductController.getProduct();
      } else {
        HomeServicesController homeServicesController = Get.find();
        homeServicesController.getServices();
      }
      statusRequest = StatusRequest.success;
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onClose() {
    descount.dispose();
    firstDateDiscount.dispose();
    lastDateDiscount.dispose();
    super.onClose();
  }
}
