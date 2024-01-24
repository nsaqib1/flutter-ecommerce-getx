import 'package:flutter_ecommerce_getx/data/models/create_profile_params.dart';
import 'package:flutter_ecommerce_getx/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../data/models/profile_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  ProfileModel _profile = ProfileModel();

  ProfileModel get profile => _profile;

  Future<bool> createProfile(String token, CreateProfileParams params) async {
    _inProgress = true;
    update();

    final response = await NetworkCaller().postRequest(
      Urls.createProfile,
      token: token,
      body: params.toJson(),
    );
    _inProgress = false;

    if (response.isSuccess) {
      final profileData = response.responseData['data'];
      _profile = ProfileModel.fromJson(profileData);
      await Get.find<AuthController>().saveUserDetails(token, _profile);
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      update();
      return false;
    }
  }
}
