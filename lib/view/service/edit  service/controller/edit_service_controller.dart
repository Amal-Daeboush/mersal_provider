import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/category_model.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/home/home%20product/controller/home_product_controller.dart';
import 'package:provider_mersal/view/home/home%20service/controller/home_services_controller.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class EditServiceController extends GetxController {
  CategoryModel? selectedCategory;
  RxBool isLoading = false.obs;
  List<File> selectedImages = [];
  String message = '';
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  List<CategoryModel> categories = [];
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController service_time = TextEditingController();
  TextEditingController descount = TextEditingController();
  TextEditingController firstDateDiscount = TextEditingController();

  TextEditingController lastDateDiscount = TextEditingController();
  int? categoryId;
  bool isDescount = false;
  void setSelectedCategory(CategoryModel? category) {
    selectedCategory = category;
    for (var c in categories) {
      if (c.name == selectedCategory) {
        categoryId == c.id;
        break;
      }
    }

    update();
  }

  Future<void> selectDurationWithTimePicker() async {
    TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay(hour: 0, minute: 30), // الوقت الافتراضي
      helpText: 'اختر مدة الخدمة',
      confirmText: 'تم',
      cancelText: 'إلغاء',
    );

    if (picked != null) {
      // تحويل الوقت إلى صيغة نصية مناسبة (مثلاً: 1 ساعة و 30 دقيقة)
      String durationText = '';
      if (picked.hour > 0) durationText += '${picked.hour} ساعة ';
      if (picked.minute > 0) durationText += '${picked.minute} دقيقة';

      service_time.text =
          durationText.trim(); // أو مثلاً "${picked.hour}:${picked.minute}"
      update();
    }
  }

  Future<dynamic> getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ApiLinks.getCategoriesService,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
          Get.snackbar(
            'Error',
            message,
            snackPosition: SnackPosition.TOP,
          ); // عرض رسالة الخطأ
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          Get.snackbar(
            'Error',
            message,
            snackPosition: SnackPosition.TOP,
          ); // عرض رسالة الخطأ
        }
        update();
      },
      (data) {
        if (data != null && data is List) {
          categories =
              data.map((item) {
                return CategoryModel.fromJson(item);
              }).toList();
          //    filteredCategories = categoriesApi; // عند البداية لا يوجد فلترة
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          categories = [];

          Get.snackbar(
            'خطأ',
            message,
            snackPosition: SnackPosition.TOP,
          ); // عرض رسالة الخطأ
        }
        update();
      },
    );
  }

  @override
  void onInit() {
    getCategories();
    nameController.text = productModel.name;
    descController.text = productModel.description;

    priceController.text = productModel.price;
    service_time.text = productModel.timeOfService!;
    super.onInit();
  }

  final ProductModel productModel;

  EditServiceController({required this.productModel});
  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await picker.pickMultiImage();
      if (images != null && images.isNotEmpty) {
        selectedImages.addAll(images.map((image) => File(image.path)).toList());
        update();
      } else {
        Get.snackbar('خطأ', 'لم يتم اختيار صور');
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في اختيار الصور: $e');
    }
  }

  /// رفع المنتج مع الصور
  Future<void> updateService() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse('${ApiLinks.update_service}/${productModel.id}');
      var request = http.MultipartRequest("POST", uri);

      // Headers with token
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['name'] = nameController.text;
      request.fields['description'] = descController.text;
      request.fields['category_id'] = selectedCategory!.id.toString();
      request.fields['price'] = priceController.text;
      request.fields['time_of_service'] = service_time.text;

      // ✅ فقط إذا المستخدم اختار صور جديدة
      if (selectedImages.isNotEmpty) {
        for (var imageFile in selectedImages) {
          request.files.add(
            await http.MultipartFile.fromPath('images[]', imageFile.path),
          );
        }
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeResponse = json.decode(responseData);
        CustomSnackBar('تم رفع المنتج بنجاح', true);

        // تحديث المنتجات في الصفحة الرئيسية
        HomeServicesController homeProductController = Get.find();
        homeProductController.getServices();

        statusRequest = StatusRequest.success;
      } else {
        print(responseData);
        CustomSnackBar(
          'فشل في رفع المنتج! رمز الحالة: ${response.statusCode}',
          false,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print("❌ خطأ: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء رفع المنتج',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    update();
  }

  addDiscount(String id) async {
    if (descount.text.isEmpty ||
        firstDateDiscount.text.isEmpty ||
        lastDateDiscount.text.isEmpty) {
      Get.snackbar('خطأ', 'يرجى تعبئة جميع بيانات الخصم');
      return;
    }

    isLoading.value = true;

    var response = await ApiRemote().AddDiscountModel(
      {
        "value": descount.text,
        "from_time": firstDateDiscount.text,
        "to_time": lastDateDiscount.text,
      },
      ApiLinks.addServiceDiscount,
      id,
    );

    isLoading.value = false;

    if (response == StatusRequest.success) {
       HomeServicesController homeServicesController = Get.find();
        homeServicesController.getServices();
      Get.snackbar('نجاح', 'تمت إضافة الخصم بنجاح');
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
    }
  }
}
