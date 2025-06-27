import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/app_routes.dart';

class OnboardingController extends GetxController {
  static OnboardingController instance = Get.find();

  void goToLoginPage(){
    Get.offNamed(AppRoutes.login);
  }
}
