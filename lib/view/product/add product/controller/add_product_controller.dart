import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/category_model.dart';
import 'package:provider_mersal/model/food_type_model.dart';
import 'package:provider_mersal/view/home/home%20product/controller/home_product_controller.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class AddProductController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequestFood = StatusRequest.none;
  RxBool isLoading = false.obs;
  List<FoodTypeModel> foodtypes = [];
  bool isDescount = false;
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController descount = TextEditingController();
  TextEditingController firstDateDiscount = TextEditingController();

  TextEditingController lastDateDiscount = TextEditingController();

  int? categoryId;
  double? newprice;
  int? FoodId;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  CategoryModel? selectedCategory;
  FoodTypeModel? selectedFood;
  List<CategoryModel> categories = [];
  List<File> selectedImages = [];
  String message = '';
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

  double calculateDiscountedPrice() {
    double originalPrice = double.tryParse(price.text) ?? 0;
    double discountPercent = double.tryParse(descount.text) ?? 0;

    if (discountPercent < 1 || discountPercent > 100) {
      return originalPrice; // إذا كانت قيمة الخصم غير منطقية، أعد السعر الأصلي
    }

    double discountValue = originalPrice * (discountPercent / 100);
    double newPrice = originalPrice - discountValue;

    return newPrice;
  }

  void setSelectedFood(FoodTypeModel? food) {
    selectedFood = food;
    for (var c in foodtypes) {
      if (c.title == selectedFood) {
        FoodId == c.id;
        break;
      }
    }
    update();
  }

  onInit() {
    super.onInit();
    getCategories();
    if (ConstData.user!.user.type == 'food_provider') {
      getFoodTypes();
    }
    price.addListener(_updateDiscountedPrice);
    descount.addListener(_updateDiscountedPrice);
  }

  double discountedPrice = 0.0;

  void _updateDiscountedPrice() {
    double originalPrice = double.tryParse(price.text) ?? 0;
    double discountPercent = double.tryParse(descount.text) ?? 0;

    if (discountPercent < 1 || discountPercent > 100) {
      discountedPrice = originalPrice;
    } else {
      discountedPrice = originalPrice - (originalPrice * discountPercent / 100);
    }

    update(); // لتحديث الواجهة

    super.onInit();
  }

  /// اختيار عدة صور
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

  Future<void> addProduct() async {
    if (!keyForm.currentState!.validate()) {
      Get.snackbar('تنبيه', 'يرجى ملء الحقول بشكل صحيح');
      return;
    }

    if (selectedImages.isEmpty) {
      Get.snackbar('تنبيه', 'يرجى اختيار صورة واحدة على الأقل');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse(ApiLinks.add_product);
      var request = http.MultipartRequest("POST", uri);

      // إضافة التوكن في الهيدر
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // تعبئة الحقول
      request.fields['name'] = name.text;
      request.fields['description'] = des.text;
      request.fields['category_id'] = selectedCategory!.id.toString();
      request.fields['price'] = price.text;
      request.fields['quantity'] = quantity.text;
      if (ConstData.user!.user.type == 'food_provider') {
        request.fields["food_type_id"] = selectedFood!.id.toString();
      }
      // إضافة الصور
      for (var imageFile in selectedImages) {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', imageFile.path),
        );
      }

      // إرسال الطلب
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeResponse = json.decode(responseData);
        if (isDescount) {
          addDiscount(decodeResponse['product']['id'].toString());
        }

        CustomSnackBar('تم رفع المنتج بنجاح', true);

        // تحديث قائمة المنتجات في الصفحة الرئيسية
        HomeProductController homeProductController = Get.find();
        homeProductController.getProduct();

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

    name.clear();
    des.clear();
    price.clear();
    quantity.clear();
    selectedImages.clear();

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
      ApiLinks.addProductDiscount,
      id,
    );

    isLoading.value = false;

    if (response == StatusRequest.success) {
      Get.snackbar('نجاح', 'تمت إضافة الخصم بنجاح');
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
    }
  }

  Future<void> getFoodTypes() async {
    statusRequestFood = StatusRequest.loading;
    update();
    Crud crud = Crud();
    var response = await crud.getData(
      '${ApiLinks.myFoodTypes}',
      ApiLinks().getHeaderWithToken(),
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

        if (data != null && data["food_types"] is List) {
          List list = data["food_types"];
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

  Future<dynamic> getCategories() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ApiLinks.getCategoriesProduct,
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
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
        update();
      },
      (data) {
        if (data != null && data is List) {
          categories =
              data.map((item) {
                return CategoryModel.fromJson(item);
              }).toList();
          // عند البداية لا يوجد فلترة
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
}
