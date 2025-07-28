import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/order_model.dart';
import 'package:provider_mersal/model/other_user_model.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/model/reservation_model.dart';

import '../../../../model/commission_model.dart' show CommiessionModel;
import '../../../widgets/custom_snack_bar.dart';

class HomeProductController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestOrders = StatusRequest.loading;
  String message = '';
  String totalPending = '';
  String totalCompleted = '';
  // TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;

  List<ProductModel> products = [];

  @override
  void onInit() {
    getProduct();
    getOrderProduct();
    getCommissions();
    super.onInit();
  }

  Future<dynamic> getProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.get_Product_provider}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
        update();
      },
      (data) {
        if (data != null && data is List) {
          products =
              data.map((item) {
                return ProductModel.fromJson(item);
              }).toList();

          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          products = [];

          Get.snackbar(
            'خطأ',
            message,

            snackPosition: SnackPosition.BOTTOM,
          ); // عرض رسالة الخطأ
        }
        update();
      },
    );
  }

  deleteProduct(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().deleteProductModel(
      ApiLinks.delete_product,
      {},
      id,
    );

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تم حذف المنتج');
      statusRequest = StatusRequest.success;
      Get.back();
      getProduct();
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
      (data) async {
        if (data != null && data is Map<String, dynamic>) {
          if (ConstData.producter) {
            // product provider
            var ordersList = data["orders"];
            if (ordersList is List && ordersList.isNotEmpty) {
              orders =
                  ordersList
                      .map<OrderModel>((item) => OrderModel.fromJson(item))
                      .toList();

              for (var order in orders) {
                final userId = order.orderDetails.userId;
                final otherUser = await fetchOtherUser(userId);

                if (otherUser != null) {
                  order.userInfo = otherUser; // ✅ اربط المستخدم بالطلب
                }
              }

              statusRequestOrders = StatusRequest.success;
            } else {
              message = 'لا توجد طلبات';
              orders = [];
              statusRequestOrders = StatusRequest.failure;
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

  Future<OtherUserInfo?> fetchOtherUser(int userId) async {
    final url = '${ApiLinks.getUser}/$userId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: ApiLinks().getHeaderWithToken(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);

        final userInfoData = jsonData['user_info'];

        if (userInfoData != null) {
          return OtherUserInfo.fromJson(userInfoData);
        } else {
          print('user_info not found in response');
          return null;
        }
      } else {
        print('Failed to load user: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
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
          //  CustomSnackBar('تم جلب الأرباح', true);

          statusRequest = StatusRequest.success;
        } else {
          CustomSnackBar('خطأ في معالجة الارباح', true);
          statusRequest = StatusRequest.failure;
        }

        update();
      },
    );
  }
}
