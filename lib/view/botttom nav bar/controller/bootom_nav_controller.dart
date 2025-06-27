import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/chat%20screen/view/chat_screen.dart';

import 'package:provider_mersal/view/home/home%20service/view/home_service_screen.dart';
import 'package:provider_mersal/view/notifications%20screen/view/notification_screen.dart';

import 'package:provider_mersal/view/profile/view/profile_screen.dart';

import '../../home/home product/view/home_screen.dart';
import '../../order/view/order_screen.dart';

class BottomNavController extends GetxController {
  final String prov; // Passed as a parameter to the controller
  int page = 0; // Current selected page index
  late List<Widget> pages; // Pages will be initialized dynamically

  BottomNavController({required this.prov}) {
    // Initialize pages based on `prov`
    pages = [
      prov == 'product_provider'
          ? const HomeScreen()
          : const HomeServiceScreen(),
      if (prov != 'product_provider') ChatsScreen(),
      const OrderScreen(),
      const NotificationScreen(),
      const ProfileScreen(),
    ];
  }

  // Function to handle navigation and update the current page index
  void onTap(int index) {
    if (index != page) {
      page = index;
      update(); // Update GetX reactive state
    }
  }
}
