import 'package:get/get.dart';

class ServiceRegisterController extends GetxController {
 bool isYesChecked = false;

  void onSelect(bool isYes) {
   
      isYesChecked = isYes;
      update();
    
  }
}
