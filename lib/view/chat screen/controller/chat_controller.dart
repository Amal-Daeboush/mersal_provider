 import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/messages_model.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

import '../../../core/class/crud.dart';
import '../../../core/class/status_request.dart';


class ChatController extends GetxController {  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';

  List<MessagesModel> messages = [];
  List<MessagesModel> filteredMessages = []; // ✅ قائمة مفلترة

  @override
  void onInit() {
    getConversions();
    super.onInit();
  }

  Future<void> getConversions() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(ApiLinks.getConversations, ApiLinks().getHeaderWithToken());

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
        }
        CustomSnackBar(message, true);
        update();
      },
      (data) {
        print("Response data: $data");

        if (data != null && data is List) {
          messages = data.map((item) => MessagesModel.fromJson(item)).toList();
          filteredMessages = List.from(messages); // ✅ نسخ البيانات بعد الجلب
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          print("Invalid data structure or 'data' key is missing");
          messages = [];
          filteredMessages = [];
        }
        update();
      },
    );
  }

  // ✅ دالة البحث
  void filterMessages(String query) {
    if (query.isEmpty) {
      filteredMessages = List.from(messages);
    } else {
      filteredMessages = messages
          .where((msg) => msg.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
}
 