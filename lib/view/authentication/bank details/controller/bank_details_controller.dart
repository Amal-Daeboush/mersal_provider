import 'package:get/get.dart';

class BankDetailsController  extends GetxController{
  String? selectedValue ;
  onChanged(value) {
    selectedValue = value;
    update();
  }
}