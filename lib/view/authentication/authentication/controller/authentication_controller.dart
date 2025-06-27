import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  String selectedValue ='service_provider';
  onChanged(value) {
    selectedValue = value;
    update();// تحديث  القيمة المحددة
  }
  goToRegister(){}
}
