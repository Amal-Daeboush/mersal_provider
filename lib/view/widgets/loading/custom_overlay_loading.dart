
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/widgets/loading/custom_loading.dart';

import '../../../core/constant/app_colors.dart';

customOverlayLoading() {
  Get.bottomSheet<Widget>(
      isDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: const Column(
          children: [
            CustomLoading(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ));
}
