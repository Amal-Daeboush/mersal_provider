import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/authentication/file%20loading/widgets/custom_loading_row.dart'
    show CustomLoadingRow;
import 'package:provider_mersal/view/authentication/login/screen/login.dart';
import 'package:provider_mersal/view/authentication/register/controller/register_controller.dart';
import 'package:provider_mersal/view/authentication/register/view/product_registeer_sereen.dart';
import 'package:provider_mersal/view/authentication/register/view/service_register_screen.dart';
import 'package:provider_mersal/view/authentication/widget/food_types_dialog.dart';
import 'package:provider_mersal/view/authentication/widget/logo/custom_logo.dart';
import 'package:provider_mersal/view/widgets/custom_loading.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';
import '../../../../core/constant/styles.dart';
import '../../widget/custom_container_button/custom_button_next.dart';
import '../../widget/text_field/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  final String proveder;
  const RegisterScreen({super.key, required this.proveder});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(LoginController());
    return Scaffold(
      body: GetBuilder(
        init: RegisterController(provider: proveder),
        builder: (controller) {
          /*   if (proveder == 'product_provider' &&
    ظظ  !controller.isGeneralCaterer &&
      controller.statusRequest == StatusRequest.loading) {
   /*  return /* Center(
      child: Text(
        'يرجى الانتظار... يتم تحميل أنواع الطعام',
        style: TextStyle(fontSize: 18, color: AppColors.primaryColor),
      ),
    ); */
  } */ */
          return SafeArea(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace,
                    ),
                    child:
                        controller.isLoading
                            ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 100.w,
                                vertical: 100.h,
                              ),
                              child: Center(child: customLoadingIndictor()),
                            )
                            : Form(
                              key: controller.keyForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 80.h),
                                  Center(child: const CustomLogo()),
                                  SizedBox(height: (AppSizes.lg).h),
                                  Text(
                                    'قم بتنميه اعمالك عبر الانترنت مع مرسال!',
                                    style: Styles.style20.copyWith(
                                      color: AppColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    'انضم الينا للوصول الى المزيد من المال وتنميه اعمالك عبر الانترنت',
                                    style: Styles.style4.copyWith(
                                      color: AppColors.lightGrey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  CustomTextFormField(
                                    controller: controller.nameController,
                                    hintText: 'اسم المستخدم',
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    controller: controller.emailController,
                                    hintText: 'البريد الالكتروني',
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: controller.phoneController,
                                    hintText: 'رقم الهاتف',
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'الرجاء إدخال رقم الهوية';
                                      }
                                      if (!RegExp(
                                        r'^\d{14}$',
                                      ).hasMatch(value)) {
                                        return 'رقم الهوية يجب أن يتكون من 14 رقمًا';
                                      }
                                      return null;
                                    },

                                    controller: controller.nationalIdController,
                                    hintText: 'الرقم القومي',
                                    keyboardType: TextInputType.number,
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomLoadingRow(
                                    onPressed: () => controller.pickImage(),
                                    title: 'تحميل اثبات الهويه',
                                    icon: Iconsax.personalcard,
                                  ),
                                  controller.selectedImage == null
                                      ? Text(
                                        '🔴 يرجى تحميل صورة هويتك',
                                        style: Styles.style5.copyWith(
                                          color: AppColors.red,
                                        ),
                                      )
                                      : Text(
                                        '✅ تم تحميل صورة هويتك',
                                        style: Styles.style5,
                                      ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    controller: controller.passwordController,
                                    hintText: 'كلمة السر',
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomTextFormField(
                                    controller:
                                        controller.confpasswordController,
                                    hintText: 'تأكيد كلمة المرور',
                                    obscureText: false,
                                    isPassWord: false,
                                  ),
                                  SizedBox(height: 15.h),
                                  if (proveder == 'product_provider') ...[
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: controller.isGeneralCaterer,
                                          onChanged: (value) {
                                            controller.isGeneralCaterer =
                                                value!;
                                            print(controller.isGeneralCaterer);
                                            controller.update();
                                          },
                                        ),
                                        Text("هل أنت مزود طعام؟"),
                                      ],
                                    ),

                                    SizedBox(height: 10.h),

                                    if (controller.isGeneralCaterer)
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) => FoodTypeDialog(
                                                  controller: controller,
                                                ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors
                                                  .primaryColor, // لون الزر زهري
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ), // زوايا شبه مستطيلة
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                        ),
                                        child: Text(
                                          "أدخل أنواع الأكل",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                  ],
                                  SizedBox(height: 5.h),
                                  if (controller.isGeneralCaterer &&
                                      controller.selectedFoodTypeIds.isNotEmpty)
                                    Wrap(
                                      spacing: 6,
                                      children:
                                          controller.selectedFoodTypeIds.map((
                                            id,
                                          ) {
                                            final title =
                                                controller.foodtypes
                                                    .firstWhere(
                                                      (type) => type.id == id,
                                                    )
                                                    .title;
                                            return Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Chip(
                                                label: Text(title),
                                                onDeleted: () {
                                                  controller.selectedFoodTypeIds
                                                      .remove(id);
                                                  controller.update();
                                                },
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  Center(
                                    child: CustomButtonNext(
                                      /*    onTap: () {
                                                              if (    proveder == 'product_provider')
                                                                Get.off(ProductRegisteerSereen(
                                    prov: proveder,
                                                                ));
                                                              else
                                                                Get.off(ServiceRegisterScreen(
                                    prov: proveder,
                                                                ));
                                                            } */
                                      onTap: () {
                                        if (controller.selectedImage == null) {
                                          Get.snackbar(
                                            'تنبيه',
                                            'يرجى اختيار صورة قبل التسجيل',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                          );
                                          return;
                                        }

                                        controller.register(
                                          controller.selectedImage!,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: ' هل لديك حساب بالفعل؟ ',
                                            style: Styles.style4.copyWith(
                                              color: AppColors.lightGrey,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer:
                                                TapGestureRecognizer()
                                                  ..onTap = () {
                                                    Get.off(
                                                      LoginScreen(
                                                        provider: proveder,
                                                      ),
                                                    ); // الانتقال إلى شاشة التسجيل
                                                  },
                                            text: 'قم بتسجيل الدخول',
                                            style: Styles.style4.copyWith(
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                  ),
                ),
                if (controller.statusRequestFood == StatusRequest.loading)
                  const Card(
                    color: AppColors.primaryColorBold,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Text(
                        'يرجى الانتظار قليلاً حتى يتم جلب كل المعلومات...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
