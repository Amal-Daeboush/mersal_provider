import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/authentication/bank%20details/controller/bank_details_controller.dart';
import 'package:provider_mersal/view/authentication/bank%20details/widgets/bank_drop_down.dart';
import 'package:provider_mersal/view/authentication/bank%20details/widgets/column_bank_translet.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/logo/custom_logo.dart';
import '../widgets/billing_address.dart';
import '../widgets/column_electonic_backet.dart';

class BankDetailsScreen extends StatelessWidget {
  final String prov;
  const BankDetailsScreen({super.key, required this.prov});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<BankDetailsController>(
          init: BankDetailsController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80.h),
                  const CustomLogo(),
                  SizedBox(height: AppSizes.lg.h),
                  Text(
                    'أضف تفاصيل البنك الخاصه بك لتلقى المدفوعات',
                    style: Styles.style20.copyWith(color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  _buildBankDropDown(controller),
                  SizedBox(height: 15.h),
                  _buildPaymentDetails(controller),
                  SizedBox(height: 20.h),
                  BillingAddress(prov),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBankDropDown(BankDetailsController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.primaryColorBold),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: BankDropDown(
        selectedValue: controller.selectedValue,
        onChanged: controller.onChanged,
      ),
    );
  }

  Widget _buildPaymentDetails(BankDetailsController controller) {
    if (controller.selectedValue == 'electronic_backet') {
      return  ColumnElectronicBacket();
    } else if (controller.selectedValue == 'bank_translate') {
      return const ColumnBankTranslet();
    } else {
      return const SizedBox();
    }
  }

}




// Electronic Wallet Column




