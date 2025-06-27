import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/view/authentication/login/screen/login.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';

class VerificationController extends GetxController {
  // static VerificationController instance = Get.find();
  late String phoneNumber;
  String? verificationCode;
  final String provider;
  StatusRequest statusRequest = StatusRequest.loading;

  VerificationController({required this.provider});
  // RxInt counter = 60.obs;
  // Timer? timer;
  // waiting() {
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (counter.value == 0) {
  //       counter.value = 60;
  //       timer.cancel();
  //       return;
  //     }
  //     counter--;
  //   });
  // }
  VerificationEmail() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await ApiRemote().signUpModel({'otp': verificationCode});

    print("Response: $response");

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', ' تم التحقق من الحساب ..');

      statusRequest = StatusRequest.success;

      Get.off(LoginScreen(provider: provider));
      //   Get.off(LoginScreen(provider: provider));
    } else if (response is String) {
      // ✅ عرض رسالة الخطأ بشكل مناسب
      Get.snackbar('Error', response);

      statusRequest = StatusRequest.failure;
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');

      statusRequest = StatusRequest.failure;
    }

    update();
  }

  void checkVerificationCode() {
    if (verificationCode == '123456') {
      Get.off(LoginScreen(provider: 'product_provider'));
    } else {
      Get.snackbar("Alert", "Please enter valid number");
    }
  }

  @override
  void onInit() {
    // waiting();
    phoneNumber = '0991615304';
    // TODO: implement onInit
    super.onInit();
  }
}
