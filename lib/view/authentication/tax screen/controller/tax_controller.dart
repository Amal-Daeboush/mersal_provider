import 'package:get/get.dart';

class TaxController extends GetxController {
 bool isYesChecked = false;

  void onSelect(bool isYes) {
   
      isYesChecked = isYes;
      update();
    
  }
}