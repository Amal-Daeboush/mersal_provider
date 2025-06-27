import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/api_links.dart' show ApiLinks;
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/food_type_model.dart';

import '../../../core/class/crud.dart' show Crud;
import '../../../core/class/status_request.dart';

class FoodTypesController extends GetxController {
  StatusRequest statusRequestFood = StatusRequest.none;
  StatusRequest statusRequestgetFood = StatusRequest.none;
  String message = '';
  RxBool isLoading = false.obs;
  int? selectedFoodTypeId;

  List<FoodTypeModel> myfoodtypes = [];
  List<FoodTypeModel> foodtypes = [];
  onInit() {
    super.onInit();
    getMyFoodTypes();
  }

  Future<void> getMyFoodTypes() async {
    statusRequestFood = StatusRequest.loading;
    update();
    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.myFoodTypes}',
      ApiLinks().getHeaderWithToken(),
    );
    response.fold(
      (failure) {
        statusRequestFood = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        print("❌ فشل في الجلب: $failure");
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        myfoodtypes = [];
        update();
      },
      (data) async {
        print("✅ بيانات السيرفر: $data");

        if (data != null && data["food_types"] is List) {
          List list = data["food_types"];
          if (list.isNotEmpty) {
            myfoodtypes = list.map((e) => FoodTypeModel.fromJson(e)).toList();
            statusRequestFood = StatusRequest.success;
          } else {
            myfoodtypes = [];
            statusRequestFood = StatusRequest.failure;
          }
        } else {
          myfoodtypes = [];
          statusRequestFood = StatusRequest.failure;
        }
        update();
      },
    );
  }

  Future<void> getFoodTypes() async {
    statusRequestgetFood = StatusRequest.loading;
    update();
    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.foodTypes}',
      ApiLinks().getHeaderWithToken(),
    );
    response.fold(
      (failure) {
        statusRequestgetFood = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        print("❌ فشل في الجلب: $failure");
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        foodtypes = [];
        update();
      },
      (data) async {
        print("✅ بيانات السيرفر: $data");

        if (data != null && data["data"] is List) {
          List list = data["data"];
          if (list.isNotEmpty) {
            foodtypes = list.map((e) => FoodTypeModel.fromJson(e)).toList();
            statusRequestgetFood = StatusRequest.success;
          } else {
            foodtypes = [];
            statusRequestgetFood = StatusRequest.failure;
          }
        } else {
          foodtypes = [];
          statusRequestgetFood = StatusRequest.failure;
        }
        update();
      },
    );
  }

  deleteFoodType(String id) async {
    statusRequestFood = StatusRequest.loading;
    update();

    var response = await ApiRemote().deleteFoodTypeModel(
      ApiLinks.delete_product,
      {},
      id,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تم حذف الصنف');
      statusRequestFood = StatusRequest.success;
      Get.back();
      getMyFoodTypes();
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');
  Get.back();
      statusRequestFood = StatusRequest.failure;
    }

    update();
  }

  void addFoodType(BuildContext context, String id) async {
    isLoading.value = true;

    var response = await ApiRemote().AddFoodTypeModel({},id);

    isLoading.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', ' تم اضافة نوع الطعام');
      getMyFoodTypes();
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
    }
  }
}
