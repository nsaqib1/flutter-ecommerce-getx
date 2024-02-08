import 'dart:convert';
import 'dart:developer';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:http/http.dart';
import '../models/response_data.dart';
import 'package:get/get.dart' as getX;

class NetworkCaller {
  Future<ResponseData> getRequest(String url, {String? token}) async {
    log(url);
    log(token.toString());
    final Response response = await get(
      Uri.parse(url),
      headers: {'token': token.toString(), 'Content-type': 'application/json'},
    );
    log(response.headers.toString());
    log(response.statusCode.toString());
    log(response.body.toString());
    print(response.headers.toString());
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      getX.Get.find<AuthController>().clearAuthData();
      getX.Get.offAll(const VerifyEmailScreen());
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  Future<ResponseData> postRequest(String url, {Map<String, dynamic>? body, String? token}) async {
    log(url);
    log(body.toString());
    print(url);
    print(body.toString());
    print(token);

    final Response response = await post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {'token': token.toString(), 'Content-type': 'application/json'},
    );
    log(response.statusCode.toString());
    log(response.body.toString());
    print(response.statusCode.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      if (decodedResponse['msg'] == 'success') {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage: decodedResponse['data'] ?? 'Something went wrong',
        );
      }
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
