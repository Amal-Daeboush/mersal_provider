import 'package:get/get.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/order_model.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/model/reservation_model.dart';
import 'package:provider_mersal/view/status%20screen/view/status_screen.dart';

class HomeServicesController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestOrders = StatusRequest.loading;
  String message = '';
  String? accountStatus;
  // TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;

  List<ProductModel> products = [];

  @override
  void onInit() {
    getServices();
   getOrderProduct();
    super.onInit();
  }

 Future<void> getServices() async {
  statusRequest = StatusRequest.loading;
  update();

  Crud crud = Crud();
  var response = await crud.getData(
    ApiLinks.get_services,
    ApiLinks().getHeaderWithToken(),
  );

  response.fold(
    (failure) {
      statusRequest = StatusRequest.failure;
      message = failure == StatusRequest.offlineFailure
          ? 'تحقق من الاتصال بالانترنت'
          : 'حدث خطأ أثناء الاتصال بالخادم';
      print('❌ Error: $failure');
      Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
      update();
    },
    (data) {
      print('✅ Response: $data');

      // 🟡 حالة الخطأ من السيرفر (statusCode != 200)
      if (data is Map<String, dynamic> && data.containsKey('statusCode')) {
        int statusCode = data['statusCode'];
        var errorBody = data['error'];

        if (statusCode == 403 && errorBody['status'] == 'pending' || statusCode == 403 && errorBody['status'] == 'pand') {
          accountStatus = errorBody['status'];
          message = errorBody['error'] ?? ' حسابك غير فعال حاليا';
          statusRequest = StatusRequest.success;
          update();

          // ✅ الانتقال إلى شاشة الحالة
          Get.offAll(() => StatusScreen(status: accountStatus!, message: message));
        } else {
          message = errorBody?['message'] ?? 'حدث خطأ أثناء تحميل البيانات';
          statusRequest = StatusRequest.failure;
          products = [];

          Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
          update();
        }

        return; // نوقف هنا
      }

      // ✅ حالة الرد الصحيح: List
      if (data != null && data is List) {
        products = data.map((item) => ProductModel.fromJson(item)).toList();
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.failure;
        message = 'البيانات غير صالحة أو غير متوقعة';
        products = [];
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
      }

      update();
    },
  );
}


  deleteProduct(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().deleteProductModel(
      ApiLinks.delete_service,
      {},
      id,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تم حذف الخدمة');
      statusRequest = StatusRequest.success;
      Get.back();
      getServices();
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');

      statusRequest = StatusRequest.failure;
    }

    update();
  }

  List<OrderModel> orders = [];
  List<ReservationModel> reservcation = [];
  Future<void> getOrderProduct() async {
    statusRequestOrders = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ConstData.producter
          ? ApiLinks.getOrdersProduct
          : ApiLinks.getOrdersServices,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequestOrders = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        orders = [];
        reservcation = [];
        update();
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          if (ConstData.producter) {
            // product provider
            var ordersList = data["orders"];
            if (ordersList is List && ordersList.isNotEmpty) {
              orders =
                  ordersList
                      .map<OrderModel>((item) => OrderModel.fromJson(item))
                      .toList();

              statusRequest = StatusRequest.success;
            } else {
              message = 'لا توجد طلبات';
              orders = [];
              statusRequest = StatusRequest.failure;
              Get.snackbar(
                'تنبيه',
                message,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          } else {
            //   (reservation)
            var reservationsList = data["reservation"];
            if (reservationsList is List && reservationsList.isNotEmpty) {
              reservcation =
                  reservationsList
                      .map<ReservationModel>(
                        (item) => ReservationModel.fromJson(item),
                      )
                      .toList();

              statusRequestOrders = StatusRequest.success;
            } else {
              message = 'لا توجد حجوزات';
              reservcation = [];
              statusRequestOrders = StatusRequest.failure;
              Get.snackbar(
                'تنبيه',
                message,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
        } else {
          message = 'حدث خطأ في جلب البيانات';
          orders = [];
          reservcation = [];
          statusRequestOrders = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }

        update();
      },
    );
  }
}
