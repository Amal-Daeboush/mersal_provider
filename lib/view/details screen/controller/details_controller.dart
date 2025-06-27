
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/ratings_model.dart';

import '../../../model/api remote/api_remote.dart';
import '../../../model/replay_model.dart';

class DetailsController extends GetxController {
  List<RatingModel> ratings = [];
  Map<String, List<ReplayModel>> allReplays = {}; // ردود لكل تقييم
  Map<String, bool> loadingReplays = {}; // حالة تحميل الردود لكل تقييم

  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';
  TextEditingController comment = TextEditingController();
  TextEditingController numrate = TextEditingController();
  RxBool isLoading = false.obs;

  final int id;

  DetailsController({required this.id});

  @override
  void onInit() {
    getRatings();
    super.onInit();
  }

  Future<void> getRatings() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
    ConstData.producter?  '${ApiLinks.getRatingProductProvider}/$id':'${ApiLinks.getRatingServiceProvider}/$id',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message = failure == StatusRequest.offlineFailure
            ? 'تحقق من الاتصال بالانترنت'
            : 'حدث خطأ';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) {
        if (data != null && data is List) {
          ratings = data.map((item) => RatingModel.fromJson(item)).toList();
          statusRequest = StatusRequest.success;
        } else {
          message = 'حدث خطأ';
          ratings = [];
          statusRequest = StatusRequest.failure;
        }
        update();
      },
    );
  }

  Future<void> getReplays(String rateId) async {
    loadingReplays[rateId] = true;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ConstData.producter?
      '${ApiLinks.getAllReplays}/$rateId':      '${ApiLinks.getAllReplaysSrervice}/$rateId',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        allReplays[rateId] = [];
        Get.snackbar('خطأ', 'فشل تحميل الردود');
      },
      (data) {
        if (data != null && data is List) {
          allReplays[rateId] = data.map((e) => ReplayModel.fromJson(e)).toList();
        } else {
          allReplays[rateId] = [];
        }
      },
    );

    loadingReplays[rateId] = false;
    update();
  }

  void addReplayRate(BuildContext context, String rateId) async {
    if (comment.text.isNotEmpty) {
      isLoading.value = true;

      var response = await ApiRemote().AddrateModel({
        'comment': comment.text,
      }, rateId);

      isLoading.value = false;
      comment.clear();

      if (response == StatusRequest.success) {
        Get.snackbar('نجاح', 'تمت إضافة الرد');
        await getReplays(rateId);
      } else {
        Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
      }
    } else {
      Get.snackbar('خطأ', 'من فضلك املىء الحقول');
    }
  }

  Future<void> deleteReplay(String replayId, String rateId) async {
    var result = await ApiRemote().deleteReplay({}, replayId);
    if (result == StatusRequest.success) {
      Get.snackbar('تم', 'تم حذف الرد');
      await getReplays(rateId);
    } else {
      Get.snackbar('خطأ', 'فشل الحذف');
    }
  }

  Future<void> editReplay(String replayId, String rateId, String newComment) async {
    var result = await ApiRemote().editReplay(replayId, {'comment': newComment, '_method': 'PUT'});
    if (result == StatusRequest.success) {
      Get.snackbar('تم', 'تم تعديل الرد');
      await getReplays(rateId);
    } else {
      Get.snackbar('خطأ', 'فشل التعديل');
    }
  }
}
