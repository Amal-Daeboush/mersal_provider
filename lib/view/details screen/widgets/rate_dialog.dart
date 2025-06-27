import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/replay_model.dart';
import 'package:provider_mersal/view/details%20screen/controller/details_controller.dart';
import 'package:provider_mersal/view/details%20screen/widgets/show_editing_dialog.dart';

void rateDialog(
  BuildContext context,
  ReplayModel replay,
  DetailsController controller,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dialog',
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedValue = Curves.easeInOut.transform(animation.value);

      return Transform.translate(
        offset: Offset(0, -100 + (100 * (1 - curvedValue))),
        child: Opacity(
          opacity: animation.value,
          child: Center(
            child: SizedBox(
              width: 350.w,
              height: 250, // 👈 عرض الديالوغ
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                title: const Text('', style: TextStyle(fontSize: 0)),
                content: Text(
                  'اختر ما تريد فعله بردك',
                  style: Styles.style1.copyWith(fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                    onPressed: () async {
                Get.back();
                  await controller.deleteReplay(
                    replay.id.toString(),
                    replay.rating_id.toString(),
                  );
                },
                    child: Text('حذف الرد', style: Styles.style4),
                  ),
                  TextButton(
                    onPressed: () {
                  Get.back();
                  showEditDialog(context, replay, controller);
                },
                    child: Text(
                      'تعديل الرد',
                      style: Styles.style4.copyWith(color: AppColors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
