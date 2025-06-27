import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/other_user_model.dart';
import 'package:provider_mersal/model/reservation_model.dart';

import '../../../model/order_model.dart';

class OrderController extends GetxController {
  List<OrderModel> acceptOrders = [];
  List<OrderModel> cancelOrders = [];
  List<OrderModel> waitOrders = [];
  List<OrderModel> orders = [];
  List<OtherUserInfo> users = [];
  List<ReservationModel> reservcation = [];
  List<ReservationModel> acceptReservation = [];
  List<ReservationModel> cancelReservation = [];
  List<ReservationModel> waitReservation = [];
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';

  @override
  void onInit() {
    super.onInit();
    getOrderProduct();
  }

  Future<void> getOrderProduct() async {
    statusRequest = StatusRequest.loading;
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
        statusRequest = StatusRequest.failure;
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

              waitOrders =
                  orders
                      .where((item) => item.orderDetails.status == 'pending')
                      .toList();

              cancelOrders =
                  orders
                      .where((item) => item.orderDetails.status == 'cancelled')
                      .toList();

              acceptOrders =
                  orders
                      .where((item) => item.orderDetails.status == 'complete')
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

              waitReservation =
                  reservcation
                      .where((item) => item.status == 'pending')
                      .toList();

              cancelReservation =
                  reservcation
                      .where((item) => item.status == 'cancelled')
                      .toList();

              acceptReservation =
                  reservcation
                      .where((item) => item.status == 'complete')
                      .toList();

              statusRequest = StatusRequest.success;
            } else {
              message = 'لا توجد حجوزات';
              reservcation = [];
              statusRequest = StatusRequest.failure;
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
          statusRequest = StatusRequest.failure;
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


  /*  Future<void> getOrderServices() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ConstData.producter
          ? '${ApiLinks.getOrdersProduct}'
          : '${ApiLinks.getOrdersServices}',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        update();
        orders = [];
      },
      (data) {
        if (data != null && data is Map<String, dynamic>) {
          // نجيب قائمة الطلبات من المفتاح "orders"
          var ordersList = data["orders"];
          if (ordersList is List && ordersList.isNotEmpty) {
            orders =
                ordersList
                    .map<OrderModel>((item) => OrderModel.fromJson(item))
                    .toList();
            statusRequest = StatusRequest.success;
            waitOrders =
                orders.where((item) => item.orderDetails.status == 'pending').toList();

            cancelOrders =
                orders
                    .where((item) => item.orderDetails.status == 'cancelled')
                    .toList();

            acceptOrders =
                orders
                    .where((item) => item.orderDetails.status == 'complete')
                    .toList();
          } else {
            message = 'لا توجد طلبات';
            orders = [];
            statusRequest = StatusRequest.failure;
            Get.snackbar('تنبيه', message, snackPosition: SnackPosition.BOTTOM);
          }
        } else {
          message = 'حدث خطأ في جلب البيانات';
          orders = [];
          statusRequest = StatusRequest.failure;
          Get.snackbar('خطأ', message, snackPosition: SnackPosition.BOTTOM);
        }
        update();
      },
    );
  } */
}
