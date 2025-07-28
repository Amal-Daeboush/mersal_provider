import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/core/sevices/sevices.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/user_model.dart';
import 'package:provider_mersal/view/address/screen/address.dart';
import 'package:provider_mersal/view/authentication/verfication/view/verfication_phon_screen.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  bool obscureText = false;
  changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> keyFormphone = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();

  StatusRequest statusRequest = StatusRequest.loading;
  bool isLoading = false;

  Login() async {
    if (keyForm.currentState!.validate()) {
      isLoading = true;
      statusRequest = StatusRequest.loading;
      update();

      var response = await ApiRemote().loginModel({
        'email': emailController.text,
        'password': passwordController.text,
      });

      print("Response: $response");

      if (response == StatusRequest.success) {
        Get.snackbar('نجاح', 'تم تسجيل الدخول');
        statusRequest = StatusRequest.success;
        isLoading = false;

        ConstData.user!.user.type == 'service_provider'
            ? await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              false,
            )
            : await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              true,
            );

        await MyServices().setConstProductVendor();
        ConstData.user!.user.otp == '1'
            ? Get.off(AddressScreen(isfromHome: false))
            : Get.off(VerificationPhonScreen(
              email: emailController.text,
              isForgetpass: false,
             
            )) ;
      } else if (response is String) {
        // ✅ عرض رسالة الخطأ بشكل مناسب
        Get.snackbar('Error', response);
        isLoading = false;
        statusRequest = StatusRequest.failure;
      } else {
        Get.snackbar('خطأ', 'حدث خطأ');
        isLoading = false;
        statusRequest = StatusRequest.failure;
      }

      emailController.clear();
      passwordController.clear();
      update();
    } else {
      Get.snackbar('خطأ', 'من فضلك املىء الحقول');
      emailController.clear();
      passwordController.clear();
    }
  }

  Future<void> loginGoogle(bool isgoogle) async {
    try {
      // 1. افتح رابط Google OAuth
      final Uri googleUri = Uri.parse(isgoogle? ApiLinks.google:ApiLinks.facebook);
      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch ${isgoogle? ApiLinks.google:ApiLinks.facebook}';
      }

      // 2. بعد تسجيل الدخول وإعادة التوجيه، يجب أن تستقبل التوكن من الخادم
      // مثال لاستدعاء API لاسترجاع التوكن
      final response = await http.get(Uri.parse(ApiLinks.google));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodeResponse = jsonDecode(response.body);
        final token = decodeResponse['access_token'];
        var user = UserModel.fromRawJson(response.body);

        await MyServices().saveUserInfo(user);
        await MyServices().setConstuser();
        await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);
        await MyServices().setConstToken();
        ConstData.user!.user.type == 'service_provider'
            ? await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              false,
            )
            : await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              true,
            );

        await MyServices().setConstProductVendor();
        BottomNavBarScreen(
          prov: ConstData.producter ? 'product_provider' : 'service_provider',
        );
      } else {
        throw 'Failed to login with Google';
      }
    } catch (e) {
      print('Google login error: $e');
      Get.snackbar('Error', 'Google login failed');
    }
  }
}
