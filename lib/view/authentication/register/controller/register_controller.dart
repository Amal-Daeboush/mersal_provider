import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/food_type_model.dart';
import 'package:provider_mersal/view/authentication/login/screen/login.dart';import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/constant/app_colors.dart';

class RegisterController extends GetxController {
  final String provider;
  File? selectedImage;
  FoodTypeModel? selectedType;
  List<FoodTypeModel> foodtypes = [];
  bool isGeneralCaterer = false;
  List<int> selectedFoodTypeIds = [];

  final ImagePicker picker = ImagePicker();
  bool obscureText = false;
  changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  RegisterController({required this.provider});
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestFood = StatusRequest.none;
  bool isLoading = false;
  @override
  void onInit() {
    if (provider == 'product_provider') {
      getFoodTypes();
    }

    super.onInit();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);
        update(); // ✅ هذا هو المطلوب لتحديث الواجهة مباشرة

        //    Get.snackbar('خطأ', 'لم يتم اختيار صورة');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في اختيار الصورة: $e');
    }
  }

  Future<void> register(File imageFile) async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('تنبيه', 'يرجى ملء الحقول بشكل صحيح');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse(ApiLinks.register);
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(ApiLinks().getHeader());

      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      );
      request.files.add(multipartFile);

      request.fields["name"] = nameController.text;
      request.fields["email"] = emailController.text;
      //    request.fields["phone"] = phoneController.text;
      request.fields["password"] = passwordController.text;
      request.fields["lat"] = '31.2001';
      request.fields["lang"] = '29.9187';
      request.fields["national_id"] = nationalIdController.text;
      request.fields["type"] =
          provider == 'product_provider' ? (isGeneralCaterer ? '4' : '1') : '2';

      if (provider == 'product_provider' && isGeneralCaterer) {
        for (int id in selectedFoodTypeIds) {
          request.fields["food_type_ids[]"] = id.toString();
        }
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      print("🔴 Response Data: $responseData");
      print("🔴 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        statusRequest = StatusRequest.success;
        CustomSnackBar('تم إنشاء الحساب بنجاح', true);
        update();
        Get.off(LoginScreen());
        print("✅ الصورة تم رفعها بنجاح!");
      } else {
        statusRequest = StatusRequest.failure;
        update();

        try {
          final Map<String, dynamic> decoded = json.decode(responseData);

          if (decoded.containsKey('errors')) {
            final Map<String, dynamic> errors = decoded['errors'];

            String errorMessage = errors.entries
                .map((entry) {
                  final messages = entry.value;
                  return messages is List
                      ? messages.map((m) => "- $m").join('\n')
                      : "- $messages";
                })
                .join('\n');

            Get.snackbar(
              'حدث خطأ',
              errorMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.primaryColorBold,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              'خطأ',
              'فشل التسجيل، حاول مرة أخرى لاحقًا.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
          return; // 👈 مهم حتى لا يكمل للكود التالي
        } catch (e) {
          Get.snackbar(
            'خطأ',
            'فشل تحليل الرد من الخادم.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print("❌ فشل تحليل JSON: $e");
          return; // 👈 مهم جداً
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("❌ خطأ أثناء رفع الصورة: $e");

      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع أثناء رفع البيانات.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String message = '';

  Future<void> getFoodTypes() async {
    statusRequestFood = StatusRequest.loading;
    update();
    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.foodTypes}',
      ApiLinks().getHeader(),
    );
    response.fold(
      (failure) {
        statusRequestFood = StatusRequest.failure;
        message =
            failure == StatusRequest.offlineFailure
                ? 'تحقق من الاتصال بالانترنت'
                : 'حدث خطأ';
        print("❌ فشل في الجلب: $failure");
        Get.snackbar('خطأ', message, snackPosition: SnackPosition.TOP);
        foodtypes = [];
        update();
      },
      (data) async {
        print("✅ بيانات السيرفر: $data");

        if (data != null && data["data"] is List) {
          List list = data["data"];
          if (list.isNotEmpty) {
            foodtypes = list.map((e) => FoodTypeModel.fromJson(e)).toList();
            statusRequestFood = StatusRequest.success;
          } else {
            foodtypes = [];
            statusRequestFood = StatusRequest.failure;
          }
        } else {
          foodtypes = [];
          statusRequestFood = StatusRequest.failure;
        }
        update();
      },
    );
  }
}
