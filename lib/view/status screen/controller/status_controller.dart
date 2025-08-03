import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/core/sevices/sevices.dart';
import 'package:provider_mersal/view/notifications%20screen/controller/notification_controller.dart';
import 'package:provider_mersal/view/status%20screen/view/status_screen.dart';

import '../../../core/class/crud.dart';

class StatusController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  String message = '';
  String? accountStatus;

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }

  Future<void> getInfo() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ConstData.user!.user.type == 'service_provider'
          ? ApiLinks.getProfileservice
          : ApiLinks.getProfileProduct,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        // خطأ في الاتصال أو الانترنت
        statusRequest = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالإنترنت'
                : 'حدث خطأ أثناء الاتصال بالسيرفر';
        update();
      },
      (data) async {
        // هنا نتحقق هل data هو Map ويحتوي على statusCode
        if (data is Map<String, dynamic> && data.containsKey('statusCode')) {
          int statusCode = data['statusCode'];
          var errorBody = data['error'];

          if (statusCode == 403 && errorBody['status'] == 'pending') {
            accountStatus = errorBody['status'];
            message = errorBody['error'] ?? 'انتظار موافقة المسؤول';
            statusRequest = StatusRequest.success;
            update();
            Get.off(
              () => StatusScreen(status: accountStatus!, message: message),
            );
          }
          if (statusCode == 403 && errorBody['status'] == 'pand') {
            accountStatus = errorBody['status'];
            message = errorBody['error'] ?? 'تم رفض حسابك  ';
            statusRequest = StatusRequest.success;
            update();
            Get.off(
              () => StatusScreen(status: accountStatus!, message: message),
            );
          } else {
            statusRequest = StatusRequest.failure;
            message = 'خطأ: ${errorBody.toString()}';
            update();
          }
        } else if (data is Map<String, dynamic>) {
          // هنا التعامل مع الرد الناجح
          if (data['data'] != null) {
            final user = data['data']['user'];
            accountStatus = user['status'];
            await MyServices.saveValue(SharedPreferencesKey.status, 'active');
            await MyServices().setConstStatus();
            statusRequest = StatusRequest.success;
            update();
            var controller = Get.put(NotificationController());
            controller.loadNotifications(false);
            Get.off(() => StatusScreen(status: accountStatus ?? 'unknown'));
          } else {
            statusRequest = StatusRequest.failure;
            message = 'حدث خطأ غير متوقع.';
            update();
          }
        } else {
          statusRequest = StatusRequest.failure;
          message = 'نوع بيانات غير متوقع.';
          update();
        }
      },
    );
  }
}
