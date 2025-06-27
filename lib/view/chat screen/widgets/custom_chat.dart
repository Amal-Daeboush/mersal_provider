import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider_mersal/model/messages_model.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/styles.dart';

class CustomChat extends StatelessWidget {
  final MessagesModel messagesModel;
  const CustomChat({super.key, required this.messagesModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.r,
        child: 
     const  Icon(Iconsax.user, size: 25,color: AppColors.black)
      ),
      title: Text(
        messagesModel.name,
        style: Styles.style1.copyWith(color: AppColors.black),
      ),
      /* subtitle: Text(
        messagesModel.
        style: Styles.style4.copyWith(color: AppColors.greyColor),
      ), */
      trailing: Text(
        DateFormat('a hh:mm ').format(messagesModel.lastMessageAt.toLocal()),
        style: Styles.style4.copyWith(color: AppColors.greyColor),
      ),
    );
  }
}
 