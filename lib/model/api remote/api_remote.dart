import 'package:provider_mersal/core/class/crud.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/core/constant/api_links.dart';
import 'package:provider_mersal/core/constant/const_data.dart';

class ApiRemote {
  Crud crud = Crud();
  Future<dynamic> signUpModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.register}',
      data,
      ApiLinks().getHeader(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> verificationModel(
    Map<String, dynamic> data,
    String url,
    bool token,
  ) async {
    var response = await Crud().postData(
      url,
      data,
      token ? ApiLinks().getHeaderWithToken() : ApiLinks().getHeader(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> loginModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.login}',
      data,
      ApiLinks().getHeader(),
      true,
    );

    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }

  Future<dynamic> updateProfileProduct(Map<String, dynamic> data) async {
    var response = await crud.postData(
      '${ApiLinks.updateProfileProduct}',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    // إذا كانت النتيجة نجاح، ارجع StatusRequest.success
    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }

  Future<dynamic> AddrateModel(Map<String, dynamic> data, String id) async {
    var response = await Crud().postData(
      ConstData.producter
          ? '${ApiLinks.answer_rating}/$id'
          : '${ApiLinks.answer_rating_service}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> AddSubModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.store_subscribe}',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> AddFoodTypeModel(Map<String, dynamic> data, String id) async {
    var response = await Crud().postData(
      '${ApiLinks.addFoodTypes}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteFoodTypeModel(
    String url,
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().postData(
      '${ApiLinks.deleteFoodTypes}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteProductModel(
    String url,
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().deleteData(
      '${url}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> UpdateInfoProductModel(Map<String, dynamic> data) async {
    var response = await Crud().post(
      ConstData.producter
          ? ApiLinks.updateProfileProduct
          : ApiLinks.updateProfileService,
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> changeStatusOrdersServicesModel(
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().post(
      '${ApiLinks.changeStatusOrdersServices}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteReplay(Map<String, dynamic> data, String id) async {
    Crud crud = Crud();
    var response = await crud.deleteData(
      ConstData.producter
          ? '${ApiLinks.deleteReplay}/$id'
          : '${ApiLinks.deleteReplayService}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );
    return response.fold((l) => l, (r) => StatusRequest.success);
  }

  Future<dynamic> editReplay(String id, Map<String, dynamic> data) async {
    Crud crud = Crud();
    var response = await crud.postData(
      ConstData.producter
          ? '${ApiLinks.updateReplay}/$id'
          : '${ApiLinks.updateReplayServise}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );
    return response.fold((l) => l, (r) => StatusRequest.success);
  }

  Future<dynamic> AddDiscountModel(
    Map<String, dynamic> data,
    String url,
    String id,
  ) async {
    var response = await Crud().postData(
      '${url}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }
}
