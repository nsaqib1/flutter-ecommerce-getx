import 'package:get/get.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/utilities/urls.dart';
import 'read_profile_data_controller.dart';

class VerifyOTPController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool _shouldNavigateCompleteProfile = true;

  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  Future<bool> verifyOTP(String email, String otp) async {
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _inProgress = false;
    if (response.isSuccess) {
      final token = response.responseData['data'];
      await Future.delayed(const Duration(seconds: 3));
      final result = await Get.find<ReadProfileDataController>().readProfileData(token);
      if (result) {
        _shouldNavigateCompleteProfile = Get.find<ReadProfileDataController>().isProfileCompleted == false;
      } else {
        _errorMessage = Get.find<ReadProfileDataController>().errorMessage;
        update();
        return false;
      }

      /// TODO: SAVE LOCAL CACHE
      /// Condition: If user profile completed, then save existing info
      /// Otherwise complete profile and then save info
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}