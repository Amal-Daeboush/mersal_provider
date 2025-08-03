import 'dart:convert';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/const_data.dart';

import 'package:provider_mersal/model/notification_model.dart';
import 'package:provider_mersal/view/notifications%20screen/controller/notification_remote.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class NotificationController extends GetxController {
  List<NotificationModel> unread = [];
  List<NotificationModel> read = [];
  int get unreadCount => unread.length;

  StatusRequest status = StatusRequest.none;

  final remote = NotificationRemote();

Future<void> loadNotifications(bool withread) async {
  status = StatusRequest.loading;
  update();

  // تحميل غير المقروءة
  if (withread) {
    final pendingRes = await remote.getPending();
    pendingRes.fold(
      (fail) => unread = [],
      (data) => unread = data,
    );
  } else {
    unread = [];
  }

  // تحميل المقروءة
  final readRes = await remote.getRead();
  readRes.fold(
    (fail) => read = [],
    (data) => read = data,
  );

  status = StatusRequest.success;
  update();
}



 Future<void> markAllAsRead() async {
  var result = await remote.markAllAsRead();
  result.fold(
    (failure) {
      print("Failed to mark all as read");
    },
    (data) {
      read.addAll(unread);
      unread.clear();
      update();
      print("Marked all as read successfully");
    },
  );
}

late PusherChannelsFlutter pusher;

@override
void onInit() {
  super.onInit();
  _initPusher();
}

 Future<void> _initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();

    await pusher.init(
      apiKey: "af4ff5b03e590e827cbe",
      cluster: "eu",
      onEvent: (PusherEvent event) {
        print("Event received: ${event.eventName} - ${event.data}");
        if (event.eventName == 'PrivateNotification') {
          final data = jsonDecode(event.data ?? '{}');
          final newNotification = NotificationModel.fromJson(data);

          unread.insert(0, newNotification);
          update();
        }
      },
    );

    await pusher.subscribe(channelName: 'notification-private-channel-${ConstData.user!.user.id}');

    await pusher.connect();
  }

  
@override
void onClose() async {
  await markAllAsRead();
  super.onClose();
}
}
