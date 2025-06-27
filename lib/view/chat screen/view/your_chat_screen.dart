import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';
import '../../../model/message_model.dart';
import '../controller/your_chat_controller.dart';
import '../widgets/input.dart';
import 'package:bubble/bubble.dart';

class YourChatScreen extends StatelessWidget {
  final String senderName;
  final int id;

  YourChatScreen({super.key, required this.senderName, required this.id});

  @override
  Widget build(BuildContext context) {
    final YourChatController chatController = Get.put(
      YourChatController(id: id.toString()),
    );

    return Scaffold(
    //  backgroundColor: const Color.fromARGB(255, 241, 239, 239),
      body: SafeArea(
        child: Container(
         
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
             SizedBox(height: 10.h,)
            ,    Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios, size: 15),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: Row(
                        children: [
                      const    CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Iconsax.user,
                                size: 25,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(width: 20.w,)
                    ,     Text(
                              senderName,
                              style: Styles.style1.copyWith(color: AppColors.black),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // الرسائل
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: chatController.chatStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          (!snapshot.hasData || snapshot.data!.isEmpty)) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 150,
                            ),
                            child: customLoadingIndictor(),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'خطأ في تحميل الرسائل: ${snapshot.error}',
                            style: Styles.style1,
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'لا يوجد رسائل بعد',
                            style: Styles.style1,
                          ),
                        );
                      }

                      final originalMessages = snapshot.data!;
                      List<dynamic> chatItems = [];
                      String? lastDate;

                      String formatDate(DateTime date) {
                        final now = DateTime.now();
                        final msgDate = DateTime(
                          date.year,
                          date.month,
                          date.day,
                        );
                        final today = DateTime(now.year, now.month, now.day);
                        final yesterday = today.subtract(Duration(days: 1));

                        if (msgDate == today) return 'اليوم';
                        if (msgDate == yesterday) return 'أمس';
                        return DateFormat('yyyy/MM/dd').format(msgDate);
                      }

                      // ✅ بناء قائمة مركبة من الرسائل والفواصل
                      for (var message in originalMessages) {
                        String currentDate = formatDate(message.createdAt);
                        if (lastDate != currentDate) {
                          chatItems.add(currentDate);
                          lastDate = currentDate;
                        }
                        chatItems.add(message);
                      }

                      // ✅ عكس القائمة بعد إضافة الفواصل
                      final reversedChatItems = chatItems.reversed.toList();

                      return ListView.separated(
                        reverse: true,
                        itemCount: reversedChatItems.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = reversedChatItems[index];

                          if (item is String) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item,
                                  style: Styles.style4.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          } else if (item is MessageModel) {
                            final isMe = id == item.receiverId;
                            final time = DateFormat(
                              'hh:mm a',
                            ).format(item.createdAt.toLocal());

                            return Bubble(
                              //style: BubbleStyle(nip: BubbleNip.rightBottom,showNip: true),
                              shadowColor:   isMe
                                      ? AppColors.greyColor:AppColors.primaryColor,
                              elevation: 5,
                              margin: BubbleEdges.all(5),
                              alignment:
                                  isMe ? Alignment.topRight : Alignment.topLeft,
                              nip:
                                  isMe ? BubbleNip.rightTop : BubbleNip.leftTop,
                              color:
                                  isMe
                                      ? AppColors.primaryColor
                                      : AppColors.greyColor2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.message,
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      fontSize: 7,
                                      color:
                                          isMe
                                              ? AppColors.whiteColor
                                              : AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return SizedBox.shrink(); // في حال العنصر غير متوقع
                        },
                      );
                    },
                  ),
                ),

                // 📥 حقل الإدخال
                CommentInputSection(
                  controller: chatController.messageController,
                  onTap: chatController.sendMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 