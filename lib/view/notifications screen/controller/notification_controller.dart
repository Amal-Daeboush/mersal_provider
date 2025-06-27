import 'package:get/get.dart';
import 'package:provider_mersal/model/notification_model.dart';

class NotificationController extends GetxController {
  List<NotificationModel> notification = [
    NotificationModel(
        status: 'order',
        text: 'لديك طلب جديد من محمد علي (#12345) لمنتج منتجات طبيه .',
        date: DateTime(1),
        isRead: false),
    NotificationModel(
        status: 'order',
        text: 'لديك طلب جديد من محمد علي (#12345) لمنتج منتجات طبيه .',
        date: DateTime(1),
        isRead: true),
    NotificationModel(
        status: 'rate',
        text: 'حصلت على تقييم 4.5 من "منتجات طبيه" من سارة أحمد: "منتج ممتاز!',
        date: DateTime(1),
        isRead: true),
    NotificationModel(
        status: 'rate',
        text: 'حصلت على تقييم 4.5 من "منتجات طبيه" من سارة أحمد: "منتج ممتاز!',
        date: DateTime(1),
        isRead: true),
    NotificationModel(
        status: 'order',
        text: 'لديك طلب جديد من محمد علي (#12345) لمنتج منتجات طبيه .',
        date: DateTime(1),
        isRead: true),
  ];
}
