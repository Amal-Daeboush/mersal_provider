import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/my_subscribe_model.dart';
import 'package:provider_mersal/model/subscribe_model.dart';

class SubscribeController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';
  // TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
RxBool isLoading = false.obs;
  List<SubscribeModel> subcribes = [];
 List<UserSubscribeModel> Mysubcribes = [];
  @override
  void onInit() {
    getSubcribes();
    super.onInit();
  }

  Future<dynamic> getSubcribes() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.get_web_subscribe}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;

        print('❌ Error: $failure.');

        if (failure == StatusRequest.offlineFailure) {
          message = 'تحقق من الاتصال بالانترنت';
        } else {
          message = failure.toString();
        }

        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) {
        print('✅ Response: $data');

        if (data != null && data is List) {
          subcribes =
              data.map((item) => SubscribeModel.fromJson(item)).toList();
          statusRequest = StatusRequest.success;
        } else {
          // طباعة رسالة الخطأ من الاستجابة (إن وُجدت)
          message = data?['message'] ?? 'حدث خطأ أثناء تحميل البيانات';
          subcribes = [];
          statusRequest = StatusRequest.failure;

          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        }

        update();
      },
    );
  }


    void addSubscribe(BuildContext context, String id) async {
    
      isLoading.value = true;

      var response = await ApiRemote().AddSubModel({
        'web_sub_id': id,
      });

      isLoading.value = false;
    

      if (response == StatusRequest.success) {
        Get.snackbar('نجاح', 'تم طلب الاشتراك  ');
        
      } else {
        Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
      }
    } 
  
   List<UserSubscribeModel> activeSubscribes = [];
List<UserSubscribeModel> pendingSubscribes = [];
List<UserSubscribeModel> finishedSubscribes = [];

bool hasFetchedActive = false;
bool hasFetchedPending = false;
bool hasFetchedFinished = false;

Future<void> getMySubcribes(String status) async {
  statusRequest = StatusRequest.loading;
  update();

  if ((status == "active" && hasFetchedActive) ||
      (status == "pending" && hasFetchedPending) ||
      (status == "finished" && hasFetchedFinished)) {
    return; // تم جلب البيانات مسبقًا، لا داعي لتكرار الطلب
  }

  Crud crud = Crud();
  var response = await crud.getData(
    '${ApiLinks.get_web_my_subscribe}?status=$status',
    ApiLinks().getHeaderWithToken(),
  );

  response.fold(
    (failure) {
      statusRequest = StatusRequest.failure;
      message = failure.toString();
      Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
      update();
    },
    (data) {
      if (data != null && data is List) {
        final parsed = data.map((e) => UserSubscribeModel.fromJson(e)).toList();

        switch (status) {
          case "active":
            activeSubscribes = parsed;
            hasFetchedActive = true;
            break;
          case "pending":
            pendingSubscribes = parsed;
            hasFetchedPending = true;
            break;
          case "finished":
            finishedSubscribes = parsed;
            hasFetchedFinished = true;
            break;
        }

        statusRequest = StatusRequest.success;
      } else {
        message = data?['message'] ?? 'حدث خطأ';
        statusRequest = StatusRequest.failure;
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
      }

      update();
    },
  );
}


  
}
