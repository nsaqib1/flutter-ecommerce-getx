import 'dart:convert';

import 'package:flutter_ecommerce_getx/data/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  String? token;
  ProfileModel? profile;

  Future<void> saveUserDetails(String t, ProfileModel p) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("profile", jsonEncode(p.toJson()));

    token = t;
    profile = p;
  }

  Future<bool> isLoggedIn() async {
    await _initialize();
    return token != null;
  }

  Future<void> _initialize() async {
    token = await _getToken();
    profile = await _getProfile();
  }

  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  Future<ProfileModel?> _getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = sharedPreferences.getString("profile");
    if (response == null) return null;

    return ProfileModel.fromJson(jsonDecode(response));
  }

  Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    profile = null;
  }
}
