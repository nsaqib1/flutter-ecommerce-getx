import 'package:flutter_ecommerce_getx/data/models/profile_model.dart';
import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utilities/urls.dart';

class ReadProfileDataController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  ProfileModel _profile = ProfileModel();

  ProfileModel get profile => _profile;

  bool _isProfileCompleted = false;

  bool get isProfileCompleted => _isProfileCompleted;

  Future<bool> readProfileData(String token) async {
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.readProfile, token: token);
    _inProgress = false;

    if (response.isSuccess) {
      final profileData = response.responseData['data'];
      if (profileData == null || profileData.length < 1) {
        _isProfileCompleted = false;
      } else {
        _profile = ProfileModel.fromJson(profileData[0]);
        _isProfileCompleted = true;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
