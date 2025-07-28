import 'package:get/get.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/commission_model.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class EarnController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  String message = '';
  String totalPending = '';
  String totalCompleted = '';
  onInit() {
   // getCommissions();
    super.onInit();
  }

  CommiessionModel? commiessionModel;

  Future<void> getCommissions() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.get_commission_product}?status=all',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالإنترنت'
                : 'حدث خطأ';
        print("❌ فشل في الجلب: $failure");
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        update();
      },
      (data) async {
        print("✅ بيانات السيرفر: $data");

        if (data != null && data is Map<String, dynamic>) {
          commiessionModel = CommiessionModel.fromJson(data);
          totalPending = '0';
          totalCompleted = '0';

          // حساب القيم بناءً على بيانات العمولة
          if (data['commission_details'] != null) {
            for (var detail in data['commission_details']) {
              if (detail['status'] == 'pending') {
                totalPending =
                    (double.parse(totalPending) + detail['commission'])
                        .toString();
              } else if (detail['status'] == 'complete') {
                totalCompleted =
                    (double.parse(totalCompleted) + detail['commission'])
                        .toString();
              }
            }
          }
          CustomSnackBar('تم جلب الأرباح', true);

          statusRequest = StatusRequest.success;
        } else {
          CustomSnackBar('خطأ في معالجة البيانات', true);
          statusRequest = StatusRequest.failure;
        }

        update();
      },
    );
  }
}
