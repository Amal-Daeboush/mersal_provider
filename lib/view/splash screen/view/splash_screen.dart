import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_image_asset.dart';
import 'package:provider_mersal/view/splash%20screen/controller/splash_controller.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

 @override
Widget build(BuildContext context) {
  return GetBuilder<SplashController>(
    init: SplashController(),
    builder: (controller) {
      return Scaffold(
        backgroundColor: const Color(0xFF7A4FBB),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.w),

              /// ✅ الصورة: تظهر تدريجيًا وتكبر
              FadeTransition(
                opacity: controller.imageFadeAnimation,
                child: ScaleTransition(
                  scale: controller.imageScaleAnimation,
                  child: Image.asset(
                    AppImageAsset.logo,
                    width: 134.4,
                    height: 86.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              /// ✅ النص: يظهر لاحقًا ويكبر
              FadeTransition(
                opacity: controller.textFadeAnimation,
                child: ScaleTransition(
                  scale: controller.textScaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مرسال',
                        style: TextStyle(
                          fontSize: 75.sp,
                          color: Colors.white,
                          fontFamily: 'Gulzar-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-8, 0),
                        child: Text(
                          'عيله تسندك',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'Cairo',
                            color: const Color(0xFFF4D03F),
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
      );
    },
  );
}

}
