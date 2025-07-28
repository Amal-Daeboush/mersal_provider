import 'package:provider_mersal/core/constant/const_data.dart';

class ApiLinks {
  static const String server = "http://192.168.1.12:8000/api";
  //static const String server= "https://highleveltecknology.com/Ms/api";
  // ================================= Images ================================== //
  static const String imagesStatic = "";
  // ================================= user info  ================================== //
  static const String getUser = "$server/user_info";
  // ================================= Auth ================================== //
  static const String register = "$server/register";
  static const String login = "$server/login";
  static const String google = "$server/auth/google/redirect";
  static const String facebook = "$server/auth/facebook/redirect";
  static const String verify_otp = "$server/verify_otp";
  static const String resend_otp = "$server/resend-otp";
  static const String forget_pass = "$server/forget-password";
  static const String reset_pass = "$server/reset-password";

  // ================================= COMMISSION================================== //
  static const String get_commission_product =
      "$server/product_provider/commissions/calculate";

  // ================================= subscribe================================== //
  static const String get_web_subscribe =
      "$server/service_provider/web_subscribe/get_all";
  static const String get_web_my_subscribe =
      "$server/service_provider/subscribe/get_all_my";
  static const String store_subscribe =
      "$server/service_provider/subscribe/store";
  // ================================= CATEGORY ================================== //
  static const String getCategoriesProduct =
      "$server/product_provider/categories/get_all";
  static const String getCategoriesService =
      "$server/service_provider/categories/get_all";

  // ================================= food types================================== //
  static const String foodTypes = "$server/food-types/index";
  static const String myFoodTypes =
      "$server/product_provider/food_type/get_all";
  static const String addFoodTypes = "$server/product_provider/food_type/add";
  static const String deleteFoodTypes =
      "$server/product_provider/food_type/remove";
  // ================================= product ================================== //
  static const String get_Product_provider =
      "$server/product_provider/product/get_all_By";
  static const String productByCategory =
      "$server/user/product/product_by_category";
  static const String add_product = "$server/product_provider/product/store";
  static const String update_product =
      "$server/product_provider/product/update";
  static const String delete_product =
      "$server/product_provider/product/delete";
  static const String show_rate_product = "$server/user/product/all_rating";

  // ================================= service ================================== //
  static const String get_services =
      "$server/service_provider/product/get_all_By";
  static const String add_service = "$server/service_provider/product/store";
  static const String update_service =
      "$server/service_provider/product/update";
  static const String delete_service =
      "$server/service_provider/product/delete";
  // ================================= rating ================================== //
  static const String getRatingProductProvider =
      "$server/product_provider/product/rating";
  static const String getRatingServiceProvider =
      "$server/service_provider/product/rating";
  static const String answer_rating =
      "$server/product_provider/answer_rating/store";
  static const String answer_rating_service =
      "$server/service_provider/answer_rating/store";
  static const String updateReplay =
      "$server/product_provider/answer_rating/update";
  static const String updateReplayServise =
      "$server/service_provider/answer_rating/update";
  static const String deleteReplay =
      "$server/product_provider/answer_rating/delete";
  static const String deleteReplayService =
      "$server/service_provider/answer_rating/delete";
  static const String getAllReplays =
      "$server/product_provider/answer_rating/get_all";
  static const String getAllReplaysSrervice =
      "$server/service_provider/answer_rating/get_all";

  // ================================= order =====================

  static const String getOrdersProduct =
      "$server/product_provider/orders/get_all";

  static const String getOrdersServices =
      "$server/service_provider/reservation/get_all";
  static const String changeStatusOrdersServices =
      "$server/service_provider/reservation/update_status";

  // ================================= order =====================
  static const String reservation = "$server/user/reservation/store";
  static const String getordergProduct = "$server/user/orders/get_product";
  // ================================= chat =====================
  static const String getConversations = "$server/getInteractedUsers";
  static const String getConversation = "$server/getConversation";
  static const String sendMessage = "$server/SendTo";
   // ================================= notification =====================
  static const String getNotification = "$server/my_notification";
  static const String readable_massege = "$server/readable_massege";
  static const String read_notificatio = "$server/read_notificatio";
  // ================================= discount =====================
  static const String addProductDiscount =
      "$server/product_provider/discount/store";
  static const String removeProductDiscount =
      "$server/product_provider/discount/destroy";
  static const String updateProductDiscount =
      "$server/product_provider/discount/update";
  static const String changeStatusProductDiscount =
      "$server/product_provider/discount/changeStatus";
  static const String addServiceDiscount =
      "$server/service_provider/discount/store";
  static const String removeServiceDiscount =
      "$server/service_provider/discount/destroy";
  static const String updateServiceDiscount =
      "$server/service_provider/discount/update";
  static const String changeStatusServiceDiscount =
      "$server/service_provider/discount/changeStatus";
  // ================================= profiles =====================
  static const String updateProfileProduct =
      "$server/product_provider/profile/update";
  static const String getProfileProduct =
      "$server/product_provider/profile/my_info";
  static const String getProfileservice =
      "$server/service_provider/profile/my_info";
  static const String updateProfileService =
      "$server/service_provider/profile/update";

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {'Accept': 'application/json'};

    return mainHeader;
  }

  Map<String, String> getHeaderWithToken() {
    Map<String, String> mainHeader = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${ConstData.token}",
    };
    return mainHeader;
  }
}
