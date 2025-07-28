import 'dart:convert';

import 'package:get/get.dart';
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/model/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constant/const_data.dart';

class MyServices extends GetxService {
  static late SharedPreferences shared;

  Future<MyServices> initialize() async {
    shared = await SharedPreferences.getInstance();

    ConstData.token = await getValue(SharedPreferencesKey.tokenkey) ?? '';
    ConstData.otp = await getValue(SharedPreferencesKey.otp) ?? '';
    ConstData.producter =
        await getValueBool(SharedPreferencesKey.producter) ?? false;

    ///  ConstData.userid = await getValue(SharedPreferencesKey.userId) ?? '';
    ConstData.nameUser = await getValue(SharedPreferencesKey.userName) ?? '';
    ConstData.national = await getValue(SharedPreferencesKey.national) ?? '';
    ConstData.emailUser = await getValue(SharedPreferencesKey.userEmail) ?? '';
    ConstData.image = await getValue(SharedPreferencesKey.image) ?? '';
    ConstData.isBoarding =
        await getValue(SharedPreferencesKey.isBoarding) ?? '';
    UserModel? userInfo = await getUserInfo();

    if (userInfo != null) {
      ConstData.user = userInfo;
    } else {
      print('User info is null, handle accordingly');
    }
    return this;
  }

  static Future<void> saveValue(String key, String value) async {
    try {
      //  final SharedPreferences prefs = await SharedPreferences.getInstance();
      await shared.setString(key, value);
    } catch (e) {
      print("Error saving value: $e");
    }
  }

  static Future<void> saveValueBool(String key, bool value) async {
    try {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      await shared.setBool(key, value);
    } catch (e) {
      print("Error saving value: $e");
    }
  }

  static getValue(String key) async {
    try {
      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
      return shared.getString(key);
    } catch (e) {
      print("Error getting value: $e");
      return null;
    }
  }

  static getValueBool(String key) async {
    try {
      //    final SharedPreferences prefs = await SharedPreferences.getInstance();
      return shared.getBool(key);
    } catch (e) {
      print("Error getting value: $e");
      return null;
    }
  }

  setConstToken() async {
    ConstData.token = await getValue(SharedPreferencesKey.tokenkey) ?? '';
    print('your token is ......');
    print(ConstData.token);
    return ConstData.token;
  }

  setConstNotationId() async {
    ConstData.national = await getValue(SharedPreferencesKey.national) ?? '';
    print('your national is ......');
    print(ConstData.national);
    return ConstData.national;
  }

  setConstProductVendor() async {
    ConstData.producter = await getValueBool(SharedPreferencesKey.producter);
    print('your product is ......');
    print(ConstData.producter);
    return ConstData.producter;
  }

  setConstId() async {
    ConstData.userid = await getValue(SharedPreferencesKey.userId) ?? '';
    print('your id is ......');
    print(ConstData.userid);
    return ConstData.token;
  }

  setConstEmail() async {
    ConstData.emailUser = await getValue(SharedPreferencesKey.userEmail) ?? '';
    print('your email is ......');
    print(ConstData.emailUser);
    return ConstData.emailUser;
  }

  setConstImage() async {
    ConstData.image = await getValue(SharedPreferencesKey.image) ?? '';
    print('your image is ......');
    print(ConstData.image);
    return ConstData.image;
  }

  setConstName() async {
    ConstData.nameUser = await getValue(SharedPreferencesKey.userName) ?? '';
    print('your name is ......');
    print(ConstData.nameUser);
    return ConstData.nameUser;
  }

  setConstuser() async {
    ConstData.user = (await getUserInfo())!;
    print('your user is ......');
    print(ConstData.user);
    return ConstData.user;
  }

  setConstBoarding() async {
    ConstData.isBoarding =
        await getValue(SharedPreferencesKey.isBoarding) ?? '';
    print('your isBoarding is ......');
    print(ConstData.isBoarding);
    return ConstData.isBoarding;
  }

  setConstOtp() async {
    ConstData.otp = await getValue(SharedPreferencesKey.otp) ?? '';
    print('your otp is ......');
    print(ConstData.otp);
    return ConstData.otp;
  }

  Future<UserModel?> getUserInfo() async {
    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = shared.getString(SharedPreferencesKey.user);

    if (userJson != null && userJson.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userJson));
    }

    return null;
  }

  //save User Information
  Future<void> saveUserInfo(UserModel user) async {
    try {
      //    final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toJson());

      await shared.setString(SharedPreferencesKey.user, userJson);

      print(' user is ......');
      print(user);
    } catch (e) {
      print("Error saving user info: $e");
    }
  }

  // clear shared
  Future<void> clear() async {
    try {
      await shared.clear();
      ConstData.token = '';
      ConstData.isBoarding = '';
      print("All shared preferences cleared");
    } catch (e) {
      print("Error clearing shared preferences: $e");
    }
  }
}

Future<void> intialService() async {
  await Get.putAsync(() => MyServices().initialize());
}
