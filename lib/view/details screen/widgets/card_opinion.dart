import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/model/ratings_model.dart';
import 'package:provider_mersal/model/replay_model.dart';
import 'package:provider_mersal/view/details%20screen/controller/details_controller.dart';
import 'package:provider_mersal/view/details%20screen/widgets/rate_dialog.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CardOpinion extends StatelessWidget {
  final RatingModel ratingModel;

  const CardOpinion({super.key, required this.ratingModel});

  @override
  Widget build(BuildContext context) {
    String formatSmartDate(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final difference = today.difference(aDate).inDays;

      if (difference == 0) {
        return 'اليوم ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (difference == 1) {
        return 'أمس ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else {
        return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    }

    DetailsController detailsController = Get.find();
    final rateId = ratingModel.id.toString();

    bool hasLoadedReplies = detailsController.allReplays.containsKey(rateId);
    bool isLoading = detailsController.loadingReplays[rateId] ?? false;
    final replays = detailsController.allReplays[rateId] ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading:  CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(ratingModel.user.image),
            ),
            title: Text(
              ratingModel.user.name,
              style: Styles.style4.copyWith(color: AppColors.charcoalGrey),
            ),
            subtitle: Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < int.parse(ratingModel.num)
                      ? Icons.star
                      : Icons.star_border,
                  size: 15,
                  color:
                      index < int.parse(ratingModel.num)
                          ? Colors.yellow
                          : Colors.grey,
                ),
              ),
            ),
            trailing: Text(
              formatSmartDate(ratingModel.createdAt),
              style: Styles.style4.copyWith(color: AppColors.greyColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ratingModel.comment,
                  style: Styles.style1.copyWith(color: AppColors.greyColor),
                ),

                // عرض الردود
                !hasLoadedReplies
                    ? Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          await detailsController.getReplays(rateId);
                        },
                        child: Text('عرض الردود', style: Styles.style4),
                      ),
                    )
                    : isLoading
                    ? const SizedBox(
                      height: 30,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                    : replays.isNotEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            replays.map((replay) {
                              return GestureDetector(
                                onLongPress:
                                    () => rateDialog(
                                      context,
                                      replay,
                                      detailsController,
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  المزود : ",
                                        style: Styles.style4.copyWith(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          replay.comment,
                                          style: Styles.style4.copyWith(
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        formatSmartDate(replay.createdAt),
                                        style: Styles.style5.copyWith(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    )
                    : Text("لا توجد ردود", style: Styles.style4),

                const SizedBox(height: 5),

                // حقل كتابة رد
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: detailsController.comment,
                            decoration: InputDecoration(
                              hintText: 'اكتب رد',
                              hintStyle: Styles.style4.copyWith(
                                color: AppColors.greyColor4,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap:
                              () => detailsController.addReplayRate(
                                context,
                                rateId,
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.primaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 5,
                            ),
                            child: Text(
                              'إضافة رد',
                              style: Styles.style5.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* void _showReplayOptions(
    BuildContext context,
    ReplayModel replay,
    DetailsController controller,
  ) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('تعديل'),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context, replay, controller);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('حذف'),
                onTap: () async {
                  Navigator.pop(context);
                  await controller.deleteReplay(
                    replay.id.toString(),
                    replay.rating_id.toString(),
                  );
                },
              ),
            ],
          ),
    );
  }
 */
}
