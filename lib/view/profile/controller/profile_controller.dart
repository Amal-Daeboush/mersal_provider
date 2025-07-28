import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/const_data.dart';


class ProfileController  extends GetxController{
  String name='';
  @override
  void onInit() {
    name=ConstData.nameUser;
    super.onInit();
  }
}