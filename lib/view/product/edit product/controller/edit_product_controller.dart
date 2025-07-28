import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/model/api%20remote/api_remote.dart';
import 'package:provider_mersal/model/category_model.dart';
import 'package:provider_mersal/model/produt_model.dart';
import 'package:provider_mersal/view/home/home%20product/controller/home_product_controller.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';
import '../../../../model/food_type_model.dart' show FoodTypeModel;

class EditProductController extends GetxController {
  CategoryModel? selectedCategory;
  FoodTypeModel? selectedFood;
  List<File> selectedImages = [];
  StatusRequest statusRequestFood = StatusRequest.none;
  List<FoodTypeModel> foodtypes = [];
  bool isDescount = false;
  String message = '';
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController descount = TextEditingController();
  TextEditingController firstDateDiscount = TextEditingController(); 
  TextEditingController lastDateDiscount = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<CategoryModel> categories = [];
  StatusRequest statusRequest = StatusRequest.none;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantity = TextEditingController();
  int? categoryId;
  int? FoodId;
  RxBool isLoading = false.obs;
  
 void setSelectedCategory(CategoryModel? category) {
  selectedCategory = category;
  categoryId = category?.id;
  update();
}

void setSelectedFood(FoodTypeModel? food) {
  selectedFood = food;
  FoodId = food?.id;
  update();
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
    super.onInit();

    nameController.text = productModel.name;
    descController.text = productModel.description;
    quantity.text = productModel.quantity!;
    priceController.text = productModel.price;

    if (ConstData.user!.user.type == 'food_provider') {
      getFoodTypes().then((_) {
        selectedFood = foodtypes.firstWhere(
          (food) => food.title == productModel.foodType,
          orElse: () => foodtypes.first,
        );
        update();
      });
    }

    getCategories().then((_) {
      selectedCategory = categories.firstWhere(
        (c) => c.id == productModel.categoryId,
        orElse: () => categories.first,
      );
      update();
    });
  }

  final ProductModel productModel;

  EditProductController({required this.productModel});
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
  Future<void> updateProduct() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var uri = Uri.parse('${ApiLinks.update_product}/${productModel.id}');
      var request = http.MultipartRequest("POST", uri);

      // Headers with token
      request.headers.addAll(ApiLinks().getHeaderWithToken());

      // Fields
      request.fields['name'] = nameController.text;
      request.fields['description'] = descController.text;
      request.fields['category_id'] = productModel.categoryId.toString();
      request.fields['price'] = priceController.text;
      request.fields['quantity'] = quantity.text;
      if (ConstData.user!.user.type == 'food_provider') {
        request.fields["food_type_id"] = selectedFood!.id.toString();
      }
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
        //  var decodeResponse = json.decode(responseData);
        CustomSnackBar('تم رفع المنتج بنجاح', true);

        // تحديث المنتجات في الصفحة الرئيسية
        HomeProductController homeProductController = Get.find();
        homeProductController.getProduct();

        statusRequest = StatusRequest.success;
      } else {
        print(responseData);
        CustomSnackBar(
          'فشل في تعديل المنتج! رمز الحالة: ${response.statusCode}',
          false,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      print("❌ خطأ: $e");
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تعديل المنتج',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    update();
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
      HomeProductController homeProductController = Get.find();
      homeProductController.getProduct();

      Get.snackbar('نجاح', 'تمت إضافة الخصم بنجاح');
    } else {
      Get.snackbar('خطأ', response is String ? response : 'حدث خطأ');
    }
  }
}
