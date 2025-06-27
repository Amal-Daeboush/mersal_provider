import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constant/app_colors.dart';
import '../controller/bootom_nav_controller.dart';

class BottomNavBarScreen extends StatelessWidget {
  final String prov;
  const BottomNavBarScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavController(prov: prov),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                // صفحات التطبيق
                SafeArea(
                  child: controller.pages[controller.page],
                ),

                // Bottom Navigation Bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white, // خلفية شفافة قليلاً
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 3,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(
                          icon: Iconsax.menu5,
                          isSelected: controller.page == 0,
                          onTap: () => controller.onTap(0),
                        ),
                     if (prov != 'product_provider')      _buildNavItem(
                          icon: Icons.message,
                          isSelected: controller.page == 1,
                          onTap: () => controller.onTap(1),
                        ),
                        _buildNavItem(
                          icon: Iconsax.receipt_11,
                          isSelected:prov == 'product_provider'? controller.page == 1:controller.page == 2,
                          onTap: () => controller.onTap(prov == 'product_provider'?1:2),
                        ),
                       _buildNavItem(
                          icon:Icons.notifications,
                          isSelected:prov == 'product_provider' ?controller.page == 2:controller.page==3,
                          onTap: () => controller.onTap(prov == 'product_provider'?2:3),
                        ), 
                        _buildNavItem(
                          icon: Icons.person_2,
                          isSelected:prov == 'product_provider'? controller.page == 3: controller.page == 4,
                          onTap: () => controller.onTap(prov == 'product_provider'?3:4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  /// Widget لبناء عنصر فردي داخل البار
  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primaryColor : AppColors.lightGrey3,
            size:isSelected ? 28:23,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
