import 'package:get/get.dart';
import 'package:provider_mersal/core/constant/const_data.dart';


class ProfileController  extends GetxController{
  String name='';
   String image='';
  @override
  void onInit() {
    name=ConstData.nameUser;
        image=ConstData.image;
    super.onInit();
  }
}