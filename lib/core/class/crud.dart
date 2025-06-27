import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:provider_mersal/core/sevices/key_shsred_perfences.dart';
import 'package:provider_mersal/model/user_model.dart';
import '../sevices/sevices.dart';
import 'helper_functions.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, String>> postData(
    String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool saveToken,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        var decodeResponse = json.decode(response.body);
        print('Response: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (saveToken) {
            var token = decodeResponse['access_token'];
            var user = UserModel.fromRawJson(response.body);

            await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);
            await MyServices().saveUserInfo(user);
            await MyServices().setConstuser();
            await MyServices().setConstToken();
          }
          return const Left(StatusRequest.success);
        } else {
          // ✅ التأكد من استخراج `message` أو `errors`
          String errorMessage = 'Unknown error occurred';
          if (decodeResponse.containsKey('message')) {
            errorMessage = decodeResponse['message'];
          } else if (decodeResponse.containsKey('errors')) {
            var errors = decodeResponse['errors'];
            if (errors is Map<String, dynamic>) {
              errorMessage = errors.values.map((e) => e.join(', ')).join('\n');
            }
          }

          return Right(errorMessage);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getData(
    String url,
    Map<String, String>? headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.get(Uri.parse(url), headers: headers);

        print(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          print(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      // print();
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> post(
    String url,
    Map<String, String>? headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(Uri.parse(url), headers: headers);

        print(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          print(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      // print();
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> postAddress(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        print(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          print(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      // print();
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, String>> postMultipartData(
    String url,
    Map<String, String> fields,
    Map<String, File> files, // ملفات متعددة (الحقل -> الملف)
    Map<String, String> headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        // إنشاء طلب متعدد الأجزاء
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);

        // إضافة الحقول
        fields.forEach((key, value) {
          request.fields[key] = value;
        });

        // إضافة الملفات
        for (var entry in files.entries) {
          var fileStream = http.ByteStream(entry.value.openRead());
          var length = await entry.value.length();
          var fileName = entry.value.path.split('/').last;

          request.files.add(
            http.MultipartFile(
              entry.key, // اسم الحقل (مثل 'image' أو 'cv')
              fileStream,
              length,
              filename: fileName,
            ),
          );
        }

        // إرسال الطلب
        var response = await request.send();

        // التعامل مع الاستجابة
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Left(StatusRequest.success);
        } else {
          return Right('Failed with status code: ${response.statusCode}');
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, String>> deleteData(
    String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.delete(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        var decodeResponse = json.decode(response.body);
        print('Response: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          //  var user = UserModel.fromRawJson(response.body);

          return const Left(StatusRequest.success);
        } else {
          // ✅ التأكد من استخراج `message` أو `errors`
          String errorMessage = 'Unknown error occurred';
          if (decodeResponse.containsKey('message')) {
            errorMessage = decodeResponse['message'];
          } else if (decodeResponse.containsKey('errors')) {
            var errors = decodeResponse['errors'];
            if (errors is Map<String, dynamic>) {
              errorMessage = errors.values.map((e) => e.join(', ')).join('\n');
            }
          }

          return Right(errorMessage);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }
}
