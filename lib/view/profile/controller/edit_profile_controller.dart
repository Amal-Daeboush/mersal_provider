import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';
import 'package:provider_mersal/view/widgets/custom_snack_bar.dart';

class EditInfoProfileController extends GetxController {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  StatusRequest statusRequest = StatusRequest.none;
  Crud crud = Crud();
  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage = File(image.path);

        // ✅ استدعاء دالة رفع الصورة
        await postImage(selectedImage!);

        //  CustomSnackBar('Image uploaded successfully', true);
      } else {
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  Future<void> postImage(File imageFile) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var uri = Uri.parse(ConstData.producter? ApiLinks.updateProfileProduct:ApiLinks.updateProfileService);
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll(ApiLinks().getHeaderWithToken());
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      );
      request.files.add(multipartFile);
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      print("🔴 Response Data: $responseData");
      print("🔴 Status Code: ${response.statusCode}");

      if (response.statusCode == 200||response.statusCode == 201) {
      //  var decodeResponse = json.decode(responseData);
      
          statusRequest = StatusRequest.success;
          CustomSnackBar('الصورة تم رفعها بنجاح!', true);
          print("✅ الصورة تم رفعها بنجاح!");
          update();
         }else {
          statusRequest = StatusRequest.failure;

          CustomSnackBar('لم يتم العثور على رابط الصورة في الاستجابة!', true);
          update();
          print("❌ لم يتم العثور على رابط الصورة في الاستجابة!");
        }
       
    } catch (e) {
      statusRequest = StatusRequest.failure;
      update();
      print("❌ خطأ أثناء رفع الصورة: $e");
    }
  }
}