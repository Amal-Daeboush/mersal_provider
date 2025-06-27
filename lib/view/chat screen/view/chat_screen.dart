import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/view/chat%20screen/controller/chat_controller.dart';
import 'package:provider_mersal/view/chat%20screen/view/your_chat_screen.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';

import '../../../core/constant/app_colors.dart';
import '../../widgets/field search/custom_field_search.dart';
import '../widgets/custom_chat.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'محادثاتك',
          style: Styles.style1.copyWith(color: AppColors.black),
        ),
      ),
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                
                  controller.statusRequest == StatusRequest.loading
                      ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 150,
                          vertical: 15,
                        ),
                        child: customLoadingIndictor(),
                      )
                      : controller.statusRequest == StatusRequest.failure
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(controller.message, style: Styles.style1),
                        ),
                      )
                      : controller.filteredMessages.isEmpty
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Text(
                            'لا يوجد رسائل بعد',
                            style: Styles.style1,
                          ),
                        ),
                      )
                      : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 2.h),
                        itemCount:
                            controller
                                .filteredMessages
                                .length, // ✅ استخدام القائمة المفلترة
                        itemBuilder: (context, index) {
                          return InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              await Get.to(
                                YourChatScreen(
                                  senderName:
                                      controller.filteredMessages[index].name,
                                  id: controller.filteredMessages[index].id,
                                ),
                              );
                              controller
                                  .getConversions(); // ✅  البي
                            },

                            child: CustomChat(
                              messagesModel: controller.filteredMessages[index],
                            ),
                          );
                        },
                      ),
                ],
              ),
            );
          },
        ),
      ), 
    );
  }
}
