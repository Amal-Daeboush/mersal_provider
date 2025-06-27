import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/core/sevices/sevices.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/view/address/screen/address.dart';
import 'package:provider_mersal/view/botttom%20nav%20bar/view/bottom_nav_bar_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  final String provider;
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

  LoginController({required this.provider});
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

        provider == 'product_provider'
            ? await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              true,
            )
            : await MyServices.saveValueBool(
              SharedPreferencesKey.producter,
              false,
            );

        await MyServices().setConstProductVendor();
        Get.off(AddressScreen(isfromHome: false,));
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

  Future<void> loginGoogle() async {
    try {
      // 1. افتح رابط Google OAuth
      final Uri googleUri = Uri.parse(ApiLinks.google);
      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch ${ApiLinks.google}';
      }

      // 2. بعد تسجيل الدخول وإعادة التوجيه، يجب أن تستقبل التوكن من الخادم
      // مثال لاستدعاء API لاسترجاع التوكن
      final response = await http.get(Uri.parse(ApiLinks.google));

      if (response.statusCode == 200) {
        final decodeResponse = jsonDecode(response.body);
        final token = decodeResponse['access_token'];

        await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);
        await MyServices().setConstToken();

        Get.off(BottomNavBarScreen(prov: provider));
      } else {
        throw 'Failed to login with Google';
      }
    } catch (e) {
      print('Google login error: $e');
      Get.snackbar('Error', 'Google login failed');
    }
  }
}
